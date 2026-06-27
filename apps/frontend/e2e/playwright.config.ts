import { defineConfig, devices } from '@playwright/test';
import { ENV } from './config/environments';

export default defineConfig({
  testDir: './specs',
  // Database state resets require sequential execution to prevent race conditions
  fullyParallel: false,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: 1, // Enforce single worker for database isolation
  reporter: 'html',
  use: {
    baseURL: ENV.frontendUrl,
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
    video: 'retain-on-failure',
  },

  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
    /* Emulated devices disabled for local dev speed; to be enabled in CI matrix
    {
      name: 'mobile-iphone',
      use: { ...devices['iPhone 15'] },
    },
    {
      name: 'tablet-ipad',
      use: { ...devices['iPad Mini'] },
    },
    */
  ],

  // Starts both backend and frontend servers during testing
  webServer: [
    {
      command: 'cd ../../backend && poetry run uvicorn lifecircle.main:create_app --factory --host 127.0.0.1 --port 8000',
      port: 8000,
      reuseExistingServer: !process.env.CI,
      stdout: 'pipe',
      stderr: 'pipe',
    },
    {
      command: 'cd .. && poetry run uvicorn lifecircle_frontend.main:app --host 127.0.0.1 --port 8001',
      port: 8001,
      reuseExistingServer: !process.env.CI,
      stdout: 'pipe',
      stderr: 'pipe',
    },
  ],
});
