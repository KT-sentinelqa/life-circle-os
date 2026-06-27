import { test, expect } from '../../fixtures/database.fixture';
import { RegisterPage } from '../../pages/register.page';

test.describe('CSRF Protection Verification', () => {
  test('should reject form submissions and return 403 Forbidden if CSRF token is tampered', async ({ page }) => {
    const registerPage = new RegisterPage(page);

    await registerPage.goto();
    await registerPage.fillForm({
      fullName: 'CSRF Attacker',
      email: 'csrf@lifecircle.app',
      password: 'SecurePassword123!',
      confirmPassword: 'SecurePassword123!',
      role: 'guardian',
    });

    // Tamper with the CSRF hidden token in the DOM before submitting
    await page.evaluate(() => {
      const csrfInput = document.querySelector('input[name="csrf_token"]') as HTMLInputElement;
      if (csrfInput) {
        csrfInput.value = 'invalid-tampered-csrf-token';
      }
    });

    // Listen for the 403 response
    const responsePromise = page.waitForResponse(response => 
      response.url().includes('/register') && response.status() === 403
    );

    await registerPage.submit();

    const response = await responsePromise;
    expect(response).toBeDefined();
    
    // Assert that we are still on the register page (no successful registration redirect happened)
    await expect(page).toHaveURL('/register');
  });
});
