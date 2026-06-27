import { test, expect } from '../../fixtures/database.fixture';
import { LoginPage } from '../../pages/login.page';
import { RegisterPage } from '../../pages/register.page';
import { DashboardPage } from '../../pages/dashboard.page';

test.describe('Login & Session Management Flow', () => {
  const email = 'loginuser@lifecircle.app';
  const password = 'SecurePassword123!';

  test.beforeEach(async ({ page }) => {
    // Pre-register user via page actions
    const registerPage = new RegisterPage(page);
    await registerPage.goto();
    await registerPage.fillForm({
      fullName: 'Login User',
      email,
      password,
      confirmPassword: password,
      role: 'guardian',
    });
    await registerPage.submit();
    await page.waitForURL('**/login?registered=true');
  });

  test('should successfully log in with correct credentials and redirect to dashboard', async ({ page, context }) => {
    const loginPage = new LoginPage(page);
    const dashboardPage = new DashboardPage(page);

    await loginPage.goto();
    await loginPage.fillForm({ email, password });
    await loginPage.submit();

    // Wait for redirect to dashboard
    await page.waitForURL('**/dashboard');
    await dashboardPage.verifyOnDashboard();

    // Assert session cookie attributes
    const cookies = await context.cookies();
    const sessionCookie = cookies.find(c => c.name === 'lifecircle_session');
    expect(sessionCookie).toBeDefined();
    expect(sessionCookie?.httpOnly).toBe(true);
  });

  test('should fail login and display error with invalid credentials', async ({ page }) => {
    const loginPage = new LoginPage(page);

    await loginPage.goto();
    await loginPage.fillForm({ email, password: 'WrongPassword1!' });
    await loginPage.submit();

    // Verify still on login page and error displays
    await expect(page).toHaveURL('/login');
    await expect(loginPage.generalError).toContainText('Invalid email or password');
  });

  test('should redirect logged-in users away from login and registration page', async ({ page }) => {
    const loginPage = new LoginPage(page);
    const dashboardPage = new DashboardPage(page);

    // Login first
    await loginPage.goto();
    await loginPage.fillForm({ email, password });
    await loginPage.submit();
    await page.waitForURL('**/dashboard');
    await dashboardPage.verifyOnDashboard();

    // Attempt to access login page
    await page.goto('/login');
    await page.waitForURL('**/dashboard');
    await expect(page).toHaveURL('/dashboard');

    // Attempt to access register page
    await page.goto('/register');
    await page.waitForURL('**/dashboard');
    await expect(page).toHaveURL('/dashboard');
  });
});
