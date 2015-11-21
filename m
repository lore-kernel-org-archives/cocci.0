From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 21 Nov 2015 13:36:37 +0900
Subject: [Cocci] [PATCH 1/1] Add SPI to platform_no_drv_owner.cocci
	warnings
In-Reply-To: <1448056925-389-1-git-send-email-afd@ti.com>
References: <1448056925-389-1-git-send-email-afd@ti.com>
Message-ID: <564FF4D5.5030303@samsung.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

W dniu 21.11.2015 o 07:02, Andrew F. Davis pisze:
> Remove .owner field if calls are used which set it automatically.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  scripts/coccinelle/api/platform_no_drv_owner.cocci | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 

Symmetric to i2c driver, looks good:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
