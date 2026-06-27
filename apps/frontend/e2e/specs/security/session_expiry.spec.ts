import { test, expect } from '../../fixtures/database.fixture';
import { LoginPage } from '../../pages/login.page';
import { RegisterPage } from '../../pages/register.page';
import { DashboardPage } from '../../pages/dashboard.page';

test.describe('Session Expiration & Guard Redirection', () => {
  const email = 'expiryuser@lifecircle.app';
  const password = 'SecurePassword123!';

  test.beforeEach(async ({ page }) => {
    const registerPage = new RegisterPage(page);
    await registerPage.goto();
    await registerPage.fillForm({
      fullName: 'Expiry User',
      email,
      password,
      confirmPassword: password,
      role: 'guardian',
    });
    await registerPage.submit();
    await page.waitForURL('**/login?registered=true');
  });

  test('should redirect authenticated users to login page once their session cookie expires', async ({ page, context }) => {
    const loginPage = new LoginPage(page);
    const dashboardPage = new DashboardPage(page);

    // Login successfully
    await loginPage.goto();
    await loginPage.fillForm({ email, password });
    await loginPage.submit();
    await page.waitForURL('**/dashboard');
    await dashboardPage.verifyOnDashboard();

    // Clear cookies to simulate session expiry
    await context.clearCookies();

    // Reload page
    await page.reload();

    // Assert redirection by middleware
    await page.waitForURL('**/login');
    await expect(page).toHaveURL('/login');
  });
});
