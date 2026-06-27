import { test, expect } from '../../fixtures/database.fixture';
import { RegisterPage } from '../../pages/register.page';

test.describe('Guardian Registration Flow', () => {
  test('should successfully register a new guardian and redirect to login page', async ({ page }) => {
    const registerPage = new RegisterPage(page);

    await registerPage.goto();
    await registerPage.fillForm({
      fullName: 'Krishna Tiwari',
      email: 'newguardian@lifecircle.app',
      password: 'SecurePassword123!',
      confirmPassword: 'SecurePassword123!',
      role: 'guardian',
    });
    await registerPage.submit();

    // Verify redirection to /login with query param by waiting for navigation
    await page.waitForURL('**/login?registered=true');
    await expect(page).toHaveURL(/\/login\?registered=true/);
  });

  test('should reject registration if passwords do not match', async ({ page }) => {
    const registerPage = new RegisterPage(page);

    await registerPage.goto();
    await registerPage.fillForm({
      fullName: 'Krishna Tiwari',
      email: 'newguardian2@lifecircle.app',
      password: 'SecurePassword123!',
      confirmPassword: 'WrongPassword123!',
      role: 'guardian',
    });
    await registerPage.submit();

    // Still on registration page and validation message displays
    await expect(page).toHaveURL('/register');
    const confirmPassError = page.locator('span[role="alert"]:has-text("Passwords do not match")');
    await expect(confirmPassError).toBeVisible();
  });

  test('should reject registration if email is already registered', async ({ page }) => {
    const registerPage = new RegisterPage(page);

    // Register user first
    await registerPage.goto();
    await registerPage.fillForm({
      fullName: 'Krishna Tiwari',
      email: 'duplicate@lifecircle.app',
      password: 'SecurePassword123!',
      confirmPassword: 'SecurePassword123!',
      role: 'guardian',
    });
    await registerPage.submit();
    await page.waitForURL('**/login?registered=true');

    // Try to register duplicate email
    await registerPage.goto();
    await registerPage.fillForm({
      fullName: 'Duplicate User',
      email: 'duplicate@lifecircle.app',
      password: 'SecurePassword123!',
      confirmPassword: 'SecurePassword123!',
      role: 'guardian',
    });
    await registerPage.submit();

    // Verify backend error is caught and shown
    const emailError = page.locator('span[role="alert"]:has-text("already exists")');
    await expect(emailError).toBeVisible();
  });
});
