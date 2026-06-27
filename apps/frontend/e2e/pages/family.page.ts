import { Page, Locator } from '@playwright/test';

export class FamilyPage {
  readonly page: Page;
  readonly nameInput: Locator;
  readonly submitButton: Locator;
  readonly generalError: Locator;

  constructor(page: Page) {
    this.page = page;
    this.nameInput = page.locator('#name');
    // Resolved via user-visible role to avoid selector collision with navbar Sign Out button
    this.submitButton = page.getByRole('button', { name: 'Create Family', exact: true });
    this.generalError = page.locator('[role="alert"]').first();
  }

  async goto(): Promise<void> {
    await this.page.goto('/family/create');
  }

  async fillForm(name: string): Promise<void> {
    await this.nameInput.fill(name);
  }

  async submit(): Promise<void> {
    await this.submitButton.click();
  }
}
