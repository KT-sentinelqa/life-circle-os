import { test, expect } from '../../fixtures/database.fixture';
import { LoginPage } from '../../pages/login.page';
import { RegisterPage } from '../../pages/register.page';
import { DashboardPage } from '../../pages/dashboard.page';

test.describe('Logout Flow', () => {
  const email = 'logoutuser@lifecircle.app';
  const password = 'SecurePassword123!';

  test.beforeEach(async ({ page }) => {
    const registerPage = new RegisterPage(page);
    await registerPage.goto();
    await registerPage.fillForm({
      fullName: 'Logout User',
      email,
      password,
      confirmPassword: password,
      role: 'guardian',
    });
    await registerPage.submit();
    await page.waitForURL('**/login?registered=true');
  });

  test('should successfully log out via Sign Out button click, clearing cookie and redirecting to login', async ({ page, context }) => {
    const loginPage = new LoginPage(page);
    const dashboardPage = new DashboardPage(page);

    // Login user
    await loginPage.goto();
    await loginPage.fillForm({ email, password });
    await loginPage.submit();
    await page.waitForURL('**/dashboard');
    await dashboardPage.verifyOnDashboard();

    // Click Sign Out button from the UI navbar (carries CSRF token)
    await page.getByRole('button', { name: 'Sign Out' }).click();

    // Verify redirected back to login page
    await page.waitForURL('**/login');
    await expect(page).toHaveURL('/login');

    // Assert session cookie is deleted
    const cookies = await context.cookies();
    const sessionCookie = cookies.find(c => c.name === 'lifecircle_session');
    expect(sessionCookie).toBeUndefined();
  });
});
