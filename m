From: ttabi@nvidia.com (Timur Tabi)
Date: Tue, 31 Jul 2018 14:48:34 -0500
Subject: [Cocci] Compacting parameters into fewer lines
In-Reply-To: <2efc7722-b133-79e6-df1e-7b489213c5fd@users.sourceforge.net>
References: <CAOZdJXUFFTEQbrKMYzC_+Zf=TgzTOQZdD9NLqBRq7Pymjph9fg@mail.gmail.com>
 <2efc7722-b133-79e6-df1e-7b489213c5fd@users.sourceforge.net>
Message-ID: <650a688e-b34d-4944-9484-249da36fb1c3@nvidia.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 07/31/2018 11:12 AM, SF Markus Elfring wrote:
> @rule1@
> expression x;
> expression list y;
> @@
> -DBG_PRINTF
> +NV_PRINTF
>            (
> -          (x),
>             y);

This doesn't work:

-        DBG_PRINTF((DBG_MODULE_OS, DEBUGLEVEL_ERRORS,
-            "NVRM: x86emu: int $%d (eax = %08x)\n", num, M.x86.R_EAX));
+        NV_PRINTF();

> @A depends on rule1@
> @@
>  NV_PRINTF(...,
> -          \(DBG_LEVEL_INFO \| DEBUGLEVEL_TRACEINFO \| DBG_LEVEL_SETUPINFO \| DEBUGLEVEL_SETUPINFO\)
> +          LEVEL_INFO
>            , ...);

This does work, thanks.

> Do you find such SmPL code adjustments useful?

Yes, thank you.  I always appreciate optimization suggestions.

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
