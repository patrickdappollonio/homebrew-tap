package template

import (
	_ "embed"
	"testing"
)

func Test_classify(t *testing.T) {
	tests := []struct {
		str  string
		want string
	}{
		{
			str:  "http-server",
			want: "HttpServer",
		},
		{
			str:  "a",
			want: "A",
		},
		{
			str:  "a-b-c",
			want: "ABC",
		},
		{
			str:  "---",
			want: "",
		},
	}
	for _, tt := range tests {
		t.Run(tt.str, func(t *testing.T) {
			if got := classify(tt.str); got != tt.want {
				t.Errorf("classify() = %v, want %v", got, tt.want)
			}
		})
	}
}
