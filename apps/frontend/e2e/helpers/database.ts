import { execSync } from 'child_process';
import path from 'path';

/**
 * Resets the Postgres tables and Redis rate-limiter keys in the test environment.
 * Executes the backend python reset script as a subprocess to keep Node code pure of DB drivers.
 */
export async function resetDatabase(): Promise<void> {
  const backendDir = path.resolve(__dirname, '../../../backend');
  const scriptPath = path.resolve(backendDir, 'scripts/reset_test_db.py');
  
  try {
    execSync(`poetry run python "${scriptPath}"`, {
      cwd: backendDir,
      env: {
        ...process.env,
        // Ensure poetry runs the correct env settings
        APP_ENV: 'test',
      },
      stdio: 'pipe',
    });
  } catch (error) {
    console.error('Failed to reset E2E test database:', error);
    throw error;
  }
}
