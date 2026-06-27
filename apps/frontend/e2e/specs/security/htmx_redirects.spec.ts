import { test, expect } from '@playwright/test';

test.describe('HTMX Redirect Headers Validation', () => {
  test('should return status 200 with HX-Redirect header when an HTMX request accesses protected route without session', async ({ request }) => {
    const response = await request.get('/dashboard', {
      headers: {
        'HX-Request': 'true',
      },
    });

    // Ensure it does not return 303 Redirect to prevent HTMX injecting partial html into targets
    expect(response.status()).toBe(200);
    
    // Assert HX-Redirect header is populated
    const headers = response.headers();
    expect(headers['hx-redirect']).toBe('/login');
  });
});
