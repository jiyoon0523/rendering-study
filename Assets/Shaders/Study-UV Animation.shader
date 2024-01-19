Shader "Study/UV Animation"{
	Properties{
		_MainTex("Albedo (RGB)", 2D) = "white"{}
		_MainTex2("Albedo (RGB)", 2D) = "white"{}
		_Speed("Float with range", Range(0.0, 5.0)) = 1.0
	}

		SubShader{
			//Tags{"RenderType" = "Opaque"}
			Tags{"RenderType" = "Transparent" "Queue"= "Transparent"}

			CGPROGRAM

	#pragma surface surf Standard alpha:fade

			sampler2D _MainTex;
			sampler2D _MainTex2;
			float _Speed;

			struct Input {
				float2 uv_MainTex;
				float2 uv_MainTex2;
			};

			void surf(Input IN, inout SurfaceOutputStandard o) {
				float2 fPos = float2(0, _Time.y);
				fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
				fixed4 d = tex2D(_MainTex2, IN.uv_MainTex - fPos*_Speed);
				o.Emission = c.rgb * d.rgb * 2;
				o.Alpha = c.a * d.a;
			}

			ENDCG
		}

		FallBack "Diffuse"
}