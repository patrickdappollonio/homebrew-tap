package licenses

import "testing"

func TestValid(t *testing.T) {
	tests := []struct {
		name     string
		license  string
		expected bool
	}{
		{
			name:     "valid license MIT",
			license:  "MIT",
			expected: true,
		},
		{
			name:     "valid license Apache-2.0",
			license:  "Apache-2.0",
			expected: true,
		},
		{
			name:     "valid license GPL-3.0-only",
			license:  "GPL-3.0-only",
			expected: true,
		},
		{
			name:     "invalid license",
			license:  "NOT-A-REAL-LICENSE",
			expected: false,
		},
		{
			name:     "empty license",
			license:  "",
			expected: false,
		},
		{
			name:     "case sensitive test",
			license:  "mit",
			expected: false,
		},
		{
			name:     "license with extra spaces",
			license:  " MIT ",
			expected: false,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			result := Valid(tt.license)
			if result != tt.expected {
				t.Errorf("Valid(%q) = %v; expected %v", tt.license, result, tt.expected)
			}
		})
	}
}

func TestValidLicensesMapInitialization(t *testing.T) {
	// Test that the validLicenses map is properly initialized
	if validLicenses == nil {
		t.Error("validLicenses map is nil")
	}

	if len(validLicenses) != len(licenses) {
		t.Errorf("validLicenses map length = %d; expected %d", len(validLicenses), len(licenses))
	}

	// Test that all licenses from the slice are in the map
	for _, license := range licenses {
		if !validLicenses[license] {
			t.Errorf("license %q is not in validLicenses map", license)
		}
	}
}

func BenchmarkValid(b *testing.B) {
	// Benchmark the Valid function
	testLicenses := []string{"MIT", "Apache-2.0", "GPL-3.0-only", "NOT-A-REAL-LICENSE"}

	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		for _, license := range testLicenses {
			Valid(license)
		}
	}
}
