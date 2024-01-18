Shader "Study/Fixed Color"{
	Properties{
		_Color("Custom color", Color) = (.25, .5, .5, 1)
	}

		SubShader{
			Pass{

				CGPROGRAM

	#pragma vertex vert
	#pragma fragment frag
	#include "UnityCG.cginc"

				fixed4 _Color;

				struct v2f {
					float4 pos: SV_POSITION;
					fixed3 color : COLOR0;
				};

				v2f vert(appdata_base v) {
					v2f o;
					o.pos = UnityObjectToClipPos(v.vertex);
					o.color = _Color;
					return o;
				}

				fixed4 frag(v2f i) : SV_Target{
					return fixed4(i.color, 1);
				}

				ENDCG
			}
	}
}