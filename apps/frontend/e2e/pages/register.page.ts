import { Page, Locator } from '@playwright/test';

export class RegisterPage {
  readonly page: Page;
  readonly fullNameInput: Locator;
  readonly emailInput: Locator;
  readonly passwordInput: Locator;
  readonly confirmPasswordInput: Locator;
  readonly roleSelect: Locator;
  readonly submitButton: Locator;
  readonly generalError: Locator;
  readonly fieldError: (name: string) => Locator;

  constructor(page: Page) {
    this.page = page;
    this.fullNameInput = page.locator('#full_name');
    this.emailInput = page.locator('#email');
    this.passwordInput = page.locator('#password');
    this.confirmPasswordInput = page.locator('#confirm_password');
    this.roleSelect = page.locator('#role');
    this.submitButton = page.getByRole('button', { name: 'Register', exact: true });
    this.generalError = page.locator('[role="alert"]').first();
    this.fieldError = (name: string) => page.locator(`input[name="${name}"] + span[role="alert"], select[name="${name}"] + span[role="alert"]`);
  }

  async goto(): Promise<void> {
    await this.page.goto('/register');
  }

  async fillForm(details: {
    fullName?: string;
    email?: string;
    password?: string;
    confirmPassword?: string;
    role?: string;
  }): Promise<void> {
    if (details.fullName !== undefined) await this.fullNameInput.fill(details.fullName);
    if (details.email !== undefined) await this.emailInput.fill(details.email);
    if (details.password !== undefined) await this.passwordInput.fill(details.password);
    if (details.confirmPassword !== undefined) await this.confirmPasswordInput.fill(details.confirmPassword);
    if (details.role !== undefined) await this.roleSelect.selectOption(details.role);
  }

  async submit(): Promise<void> {
    await this.submitButton.click();
  }
}
