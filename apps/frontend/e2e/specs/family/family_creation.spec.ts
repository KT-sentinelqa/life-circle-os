import { test, expect } from '../../fixtures/database.fixture';
import { LoginPage } from '../../pages/login.page';
import { RegisterPage } from '../../pages/register.page';
import { FamilyPage } from '../../pages/family.page';
import { DashboardPage } from '../../pages/dashboard.page';

test.describe('Family Creation & Permissions Journeys', () => {
  test('should successfully create a family circle when authenticated as a guardian', async ({ page }) => {
    const registerPage = new RegisterPage(page);
    const loginPage = new LoginPage(page);
    const familyPage = new FamilyPage(page);
    const dashboardPage = new DashboardPage(page);

    const email = 'guardian@lifecircle.app';
    const password = 'SecurePassword123!';

    // Register Guardian
    await registerPage.goto();
    await registerPage.fillForm({
      fullName: 'Guardian User',
      email,
      password,
      confirmPassword: password,
      role: 'guardian',
    });
    await registerPage.submit();
    await page.waitForURL('**/login?registered=true');

    // Login Guardian
    await loginPage.goto();
    await loginPage.fillForm({ email, password });
    await loginPage.submit();
    await page.waitForURL('**/dashboard');
    await dashboardPage.verifyOnDashboard();

    // Create Family
    await familyPage.goto();
    await familyPage.fillForm('Tiwari Family');
    await familyPage.submit();

    // Verify redirected back to dashboard
    await page.waitForURL('**/dashboard');
    await dashboardPage.verifyOnDashboard();
  });

  test('should reject family creation when authenticated as a helper (non-guardian)', async ({ page }) => {
    const registerPage = new RegisterPage(page);
    const loginPage = new LoginPage(page);
    const familyPage = new FamilyPage(page);
    const dashboardPage = new DashboardPage(page);

    const email = 'helper@lifecircle.app';
    const password = 'SecurePassword123!';

    // Register Helper
    await registerPage.goto();
    await registerPage.fillForm({
      fullName: 'Helper User',
      email,
      password,
      confirmPassword: password,
      role: 'helper',
    });
    await registerPage.submit();
    await page.waitForURL('**/login?registered=true');

    // Login Helper
    await loginPage.goto();
    await loginPage.fillForm({ email, password });
    await loginPage.submit();
    await page.waitForURL('**/dashboard');
    await dashboardPage.verifyOnDashboard();

    // Attempt to Create Family
    await familyPage.goto();
    await familyPage.fillForm('Helper Family');
    await familyPage.submit();

    // Verify backend authorization error is displayed
    await expect(familyPage.generalError).toContainText('Only guardians');
  });

  test('should redirect guest users trying to access family page to login', async ({ page }) => {
    // Attempt guest navigation directly
    await page.goto('/family/create');
    await page.waitForURL('**/login');
    await expect(page).toHaveURL('/login');
  });
});
