import '@testing-library/jest-dom';
import { render, screen } from '@testing-library/react';
import App from './App';

test('renders greeting message', () => {
  render(<App />);
  const heading = screen.getByText(/Hello, DevSecOps/i);
  expect(heading).toBeInTheDocument();
});
