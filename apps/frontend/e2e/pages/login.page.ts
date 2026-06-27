import { Page, Locator } from '@playwright/test';

export class LoginPage {
  readonly page: Page;
  readonly emailInput: Locator;
  readonly passwordInput: Locator;
  readonly submitButton: Locator;
  readonly generalError: Locator;
  readonly successMessage: Locator;

  constructor(page: Page) {
    this.page = page;
    this.emailInput = page.locator('#email');
    this.passwordInput = page.locator('#password');
    this.submitButton = page.getByRole('button', { name: 'Sign In', exact: true });
    this.generalError = page.locator('[role="alert"]').first();
    this.successMessage = page.locator('.bg-green-500\\/10, .text-green-500');
  }

  async goto(): Promise<void> {
    await this.page.goto('/login');
  }

  async fillForm(details: { email?: string; password?: string }): Promise<void> {
    if (details.email !== undefined) await this.emailInput.fill(details.email);
    if (details.password !== undefined) await this.passwordInput.fill(details.password);
  }

  async submit(): Promise<void> {
    await this.submitButton.click();
  }
}
