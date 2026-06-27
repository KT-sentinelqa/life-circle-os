import { test as baseTest } from '@playwright/test';
import { resetDatabase } from '../helpers/database';

export const test = baseTest.extend<{ dbReset: void }>({
  dbReset: [
    async ({}, use) => {
      // Clean up before test execution
      await resetDatabase();
      await use();
      // Clean up after test execution to leave environment clean
      await resetDatabase();
    },
    { auto: true }, // Auto-runs for every test utilizing this test fixture
  ],
});

export { expect } from '@playwright/test';
