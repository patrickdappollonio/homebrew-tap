package github

import "testing"

func TestChecks(t *testing.T) {
	cases := []struct {
		URL       string
		WantMacOS bool
		WantLinux bool
		WantIntel bool
		WantARM   bool
		WantARM64 bool
	}{
		{
			URL:       "foo-darwin-amd64.tar.gz",
			WantMacOS: true,
			WantIntel: true,
		},
		{
			URL:       "duality_linux_arm64.tar.gz",
			WantLinux: true,
			WantARM64: true,
		},
		{
			URL:       "armageddon_linux_amd64.tar.gz",
			WantLinux: true,
			WantIntel: true,
		},
		{
			URL:       "armageddon_linux_arm.tar.gz",
			WantLinux: true,
			WantARM:   true,
			WantARM64: false,
		},
		{
			URL:       "tool_linux_aarch64.tar.gz",
			WantLinux: true,
			WantARM64: true,
		},
		{
			URL:       "tool-darwin-aarch64.tar.gz",
			WantMacOS: true,
			WantARM64: true,
		},
	}

	for _, c := range cases {
		t.Run(c.URL, func(tt *testing.T) {
			d := Download{Filename: c.URL}

			if got := d.IsMacOS(); got != c.WantMacOS {
				tt.Errorf("IsMacOS() = %v; want %v", got, c.WantMacOS)
			}
			if got := d.IsLinux(); got != c.WantLinux {
				tt.Errorf("IsLinux() = %v; want %v", got, c.WantLinux)
			}
			if got := d.IsIntel(); got != c.WantIntel {
				tt.Errorf("IsIntel() = %v; want %v", got, c.WantIntel)
			}
			if got := d.IsARM64(); got != c.WantARM64 {
				tt.Errorf("IsARM() = %v; want %v", got, c.WantARM64)
			}
			if got := d.IsARM(); got != c.WantARM {
				tt.Errorf("IsARM() = %v; want %v", got, c.WantARM)
			}
		})
	}
}
