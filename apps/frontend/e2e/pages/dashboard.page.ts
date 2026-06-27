import { Page, Locator, expect } from '@playwright/test';

export class DashboardPage {
  readonly page: Page;
  readonly dashboardHeader: Locator;
  readonly activeMembersCard: Locator;

  constructor(page: Page) {
    this.page = page;
    this.dashboardHeader = page.locator('h3:has-text("Tiwari Family Dashboard")');
    this.activeMembersCard = page.locator('p:has-text("Active Members")');
  }

  async goto(): Promise<void> {
    await this.page.goto('/dashboard');
  }

  async verifyOnDashboard(): Promise<void> {
    await expect(this.page).toHaveURL('/dashboard');
    // Ensure dashboard specific header component is visible
    await expect(this.dashboardHeader).toBeVisible();
  }
}
