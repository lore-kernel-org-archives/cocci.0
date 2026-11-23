Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43846606A31A
	for <cocci@archiver.kernel.org>; Mon, 23 Nov 2026 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=I4L6HhUb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:mime-version:message-id:from:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0uCdHZiVVTDG+XttRZzpcPvSV82rXD7vMjRz82vFZNM=;
  b=I4L6HhUblB62/SIuYVJ/AhnvVcwUL2zS5Nk3e78MZ8e+0QzakQd1DW7M
   A4ylOgi0T2la4lrQU1O2aWf4xyAaW3qlYnmoFs8QKU+Z1UxJ6upSJefn5
   PsekE0mP9J3B9/Iax3NSgRRSh4Zldx0EHcNAi3FerPmx7NIz8+PWIhFBd
   c=;
X-CSE-ConnectionGUID: ue0YfoPoR7y8MErLosu8Mg==
X-CSE-MsgGUID: F2cwfm17SLOHH5c1eosxCQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,227,1787004000"; 
   d="scan'208";a="306841152"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Nov 2026 12:01:34 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 794C381CFA; Mon, 23 Nov 2026 12:01:34 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id E63808193D
	for <cocci@sympa.inria.fr>; Mon, 23 Nov 2026 11:46:20 +0100 (CET)
X-CSE-ConnectionGUID: FeB/M6zlSvurcUmYqQmPUg==
X-CSE-MsgGUID: YcUQayZ0SHOHqVXqfKgBSg==
IronPort-SDR: 6b04197b_ndmvixaK8gOuW5uwjG5poIixLAikX87nLd2Lu/LaiUrbLd2
 /y0GaAGAaP6V1TLAESjeSoQa0r0SnGkj4I6GCGQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EJAwDKGARrgUiAVdFaglmCQYELYDQECxkwBIRUj1OCI?=
 =?us-ascii?q?Z9QA1URAQMBDUQNBAEBAQIEhHoCjiYCHgcBBDMGDgECBAMCAwEBAQEBAQEBA?=
 =?us-ascii?q?QEBCwEBAQQBAQECAQECBAMBAQEBAhABASIZBw47hk8NjBqBJYEmAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBFwINOm0EGQEBNwE0AiYCNQEFATWDAgGCIgEGSwMRsDuLc?=
 =?us-ascii?q?n8zgQGCDAEBBoJr2zMCAwYUAQGBCS6GCIJaAYFxgxJ2gxppgSEbgg2BFYNqg?=
 =?us-ascii?q?VKBDwICgTwBAYN8gmqCERWBDJhsCT9+BBwDWSwBVRMNCgsHBYFoAzUSIQkVb?=
 =?us-ascii?q?jIdgSM7Fy9YGwYFgRxCXIESgQNdgSsoXQEhM1WBdgKCUYIAAgFJQQ4HRVMJJ?=
 =?us-ascii?q?UMSRyQiCBIJARMaLAqBGjU8CSY/FQxnAwgaBWEIAg0MdDkQMB4kLwUaJj4bC?=
 =?us-ascii?q?oEMJx8eGw4CHxAGGRgNSBEsNxUZBD5uB5N2gxkBUgYKKwsJGE4CBAQ5Wxcck?=
 =?us-ascii?q?0MCkByhdIE+hCuEdYN3gziVOhozhASUGpJULod9kF2MEIF6lWMGhUERJIFaJ?=
 =?us-ascii?q?DyBIDMaCBsVgyJQAxkPkiSFE8knRzICAToCBwIHDgMLkhyBTAEB?=
IronPort-PHdr: A9a23:BQkStRFLiZetu5aAViLaf51Gf2NDhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k20xmRBM6GtqIUw6qO6ua8AjJGuczA+Fk5M7VyFDY9wf0MmAIhBMPXQWbaF9XNKwEcI
 oFpeWQhwUuGN1NIEt31fVzYry76xzcTHhLiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyK
 wi9oRnMusUMjoZvJKQ8xgHVrndVdOhbxWNlKFGQkh3h4su84INv/z5ftv8v9sNMS7n2c7o9Q
 bdFEDkoLmc56dHkuhXEUQaB/GYXXH8MkhpPDQjF7RX6UYn0vyDnqOdz2zSUMNPvQ7wsVjqs9
 6hkRAb2hSkIKjA16G7YhNB+g6JduxKhugdww5XIb4GPNfpxZb3ScNUHTmdcRMlRVihBAoShb
 4sTCucKIOhVo5Xhq1YIsBCzHhenCv/xxTBUh3/2xaw63PonEQHaxwwrAtYCvG3JoNnpKKseV
 Oa4w67UwDjNc/9axC7x5JTVfhs8pf2AQLJ9fc/XxEIyFQ3Kk0+QpJTrMTya0eoDsHWV4ep+W
 ++xl2EqsB1xriS1y8swkITFmoAYx1bZ/it52oY1Iti4RVZ8b9G+CptfqyaaPJZ5TMMmXWFnp
 jw6waABtJGleCgK1oooxwTEZvyIdIiI5R3jVOKPLjtimH1lf7e/ig+0/EO9xeLyStO630xWr
 ipZjNbMrHYN2gTd58SZRfVz8Eis1SiS2w7d6uxJJU85mKjFJpMlzLM9mIcfvErNECH4lkj4g
 rGbe0Q69uS09ujpbKnrqoGCO4F6jAz1L6ogmsu6AesiMwgOWXCW+eei2735+032XrFKgucxk
 qnDv5DXI9kQqK2hAwJNzIov9xKyAy2l3dkYh3ULMUxJdRGdg4XrJV3DJu3zA+2ljFS2ijhrw
 ujLPr3/DZXJKXjOiLLhcqx8605Y0QYyw9Vf649NBrEPIv//RFX9tNPfDh8+PAy0x/joBM9h2
 YMZXGKDGq6ZMKXMvl+U/u8jPfWAaYsPtDv+K/Up/ePigWE6lFMHf6Slw4MbaHWiEfRnJ0WZb
 2DsgtAEEWoSsAcxUuzqiF6NXzFJaXe9Uacy6ywnBo66D4rNSZmjjb6E0iq/HJNYZGRLBF+OH
 Hvyd4iKWfcCZSKQLMJhkjEJSKWsRY4k2xyzugL20blqIO/P9y0WsZLsytd06/TKmR4s8Tx0E
 dqS03uXQ25vmWMIWjk207xhrkxm0FuD3q94g/tXFdxX+fxFSBs1NZnZz+BiEdD9RhrBfsuVS
 FahWtipHTYxQc4tzN8PeEt9ANWjjhXb3yWwGbMVlrqLBIY18q3GxXTxKdx9x27A1KY6l1YmW
 NdANXW6hq5j8AjeH5PFn12Wl6m0cqQS3zTD+X+NwmSTpE1YShB/UbvGU34FfkbWqM725kLGT
 7O3B7UnNxZNxdeMKqZIdNHll1pGRPDkONTRZ2K+hX28CgqPxrOJdIblZmYd3CTYCEUciw4d8
 niJOxYiCCq9pWzSFCFhFVf1bEP27eZzsGu1QFYswQ+Fd0FhzKK1+hANiPKGV/4dw68KtD86q
 zVsElayx9LWBMSEpwpmZKhSecoz7k9I2zGRiwsoM5i+IrpKiVkZfAB6+Ujp0kZZEIJFxO0jt
 ngthCd2N6+CmAdMcy2Vx7j/PbrYLmS09xeqPf2FkmrC2cqbr/9coM8zrE/u6UT5SyLKkl1i2
 thRiD6H44nSSREVSdT3W1o28B5zo/fbZDM87sXazy4kKrG65xnF3d9hH+450lC4Zd4KPaeaG
 RXaHModCMyjbuctngvhdQoKadhb77V8JMa6b72D0a+vMvxnmWf9gGREzYli72GmzXIjZ8mX/
 Mcl46C1gU3adxmhrAr8mOrYuqofI2ExNmS7xDihQYNVeKBoO4wMFGGlLtbxydJ5iJrgHXVf8
 Q3rHEsIjemufxfadFnhxUtQ2EAQ9GSggje9xidonisBq6Oe2GnRxr2nekVdfGFMQ2ZmgBHnJ
 o3cY8kyek+uYkBpkRKk4R2/3K1HvOFkKHGVR05Ufi/wJmUkU62qt7PEbdQdoJUv+T5aVuixe
 zX4Avb0vgca3iX/HmBf2CFzdjekvY/8lgB7j2TVJWh6rX7Qc8V9jRnF49mUSflU1zsADC527
 FufTlW4IdSz1dqTkJjHv6a1UGfgHpxffC/3zJ+R4TOh7D4iChm+kvav39z/RFJigGmrip8zD
 3WO80yvB+ujn763Ou9mYERyUVr16s4hX5p7jpN1n5YIn34TmpSS+3MD12b1K9RSn6zkPx9vD
 XYGxcDY5A/91QhtNHWMksiiW3We78J+WvqQWDtJ9wVizJFqKPa5s/oZvQUoggflhyj+QtIm2
 Gc+4fUq5W5fxuwNpgc3iC+aH7YZEFIeMivrmBCFqdu5qe8EAQTnOaj1z0d4kd27WfuPph9RQ
 l72fZAtGSI25cJ6egGEwDj47Yfqf8PVZNQYu0iPkhvOuONSLYo4ivsAgScP1XvVhXQ+0KZ7i
 BVv2cr/p42bMyB2+7r/BBdENzrzbsdV+zf3jK8YkNzEl4yoG5xgHH0MUv6KBbrzHTIRmP34C
 iWkKmVjh1DEOuv/PV6ytwE7j1ySM832HVu4B1NCi4VBbBeZKVwaxQ0QQjgg2JQ+Cwahydenf
 0B+6TQcoFX/r34ugqpkOgL+XWHWuAqzIm1sGd7PcVwPtFEEuB2dONfW9u9pGiBE4pCt5BeAL
 GCWfUUtbylBW0CJAUziIqj74NDB9+aCAe/tZ/DKYLiItalfT6LSncPpgtYgpmzccJrVbRwAR
 7Uh10FOXG50AZHckjQLEGkMkj7VKtWcvFG68zF2qca29LLqXhju7M2BEeg3U50n9haojKOEL
 +PVijx+LGMSjZ4MxlLB14U89mRK1AxJKBr8MZRRmHGLEYL+x48KUjQxRABZb40YzIoy2gRdf
 IvWjs34zPhyieMzAFpeE1Pmnc6taIoBJGT3ZzalTA6bca+LIzHG2ZS9Oq68SpBZk9h3nSfo5
 hu8TGyyHhTSumavCjCBbMER0QuxEz9048ftUT5jDWXzCZfrbgO2Kpl9iiAwyrAvwHzNMmEYP
 H53dEYH/djypWtIx/54HWJG9H9sK+KJzj2Y4+fvIZETqfJ3Ay5wmrES8DEgxrBS9i0BWO1tl
 X6YsIt1u1//2LrqqHIvQF9Upz1Mno7OoUhyJfCT6MxbQXidtBMVsTfPV1JT/YYjUpu3/PkOg
 tnXyPCqeW0Eqo2Eu5dDQZCTcp7iUjJpMAK1SmeFVk1cEm/tZDuZ3wsHyrmT7iHH9MBr7Mix3
 sNUGvkDEwVqc5FSQkV9Qo5YeM8uDG90z+bJ0J5WuSjs60SPDMRC4MKdCqrOU6u/cG7L0ekaO
 0lahu6mSOZbfozjhR44NAElzoqaERKCAYAT/n8zKVJq6ERVriokHjVriRnrMlHxsCFPR6zzw
 0BT6EM2YPxzpm3luw9lfwaX/HlswBdty4ei3G7ZcSavfv27BY8EBSCp7xptYs2nEVQyMFP6i
 0VgMH2sq6t5qbxmeCgrjQbdvcAKAvtAVehfZwdWw/iLZvIu2FAaqyO9xEYB6/GXQZ1l3BAnd
 5KhtRcik0pqccI1KKrMJaFI0kkYh6SAuTWt3/wwxwlWLlgE8WebcioF8EISMbxuKy2t9+1qo
 QuM/lkLMHALTOYvq+l2+1kVPu2By2f/1ucGJB/rceOYKKydti7LksvJClI820UUllVUqLh71
 cBwFijcH0srzbaXC1EILZ+YcVATP5cUrSKDO3nU4oCvidpvMo6wF/7lV7qLvacQ2Qe/GRoxW
 p8L9oIHF4Wt10fRKYHmKqQEwFMj/leORh3NAfJXdRaMiDpCrdu4yco9hoRdJRwUHlheGx/vu
 Zvw+Sx7oNrScYhwP1c0A6tZa1gcd+6QwGgJnFxOCDSnl6cUzBaP9Xn2oTnWBzTnKdVkY/iQa
 FVnD9T8qlBdu+CmzEXa9JnTPTSwLdN5ptrG8v8Xvb6CAvJQCKZ46gLSxNMeSHutXGrCV9WyI
 tKjDutkJcyxAXG8XFuljjszRMqkJ9ehIJ+DhgTwTJpVuo2WtNjCHcq0FzVbBBIp4u9cvuRzY
 goMZ5d9ahnt5VxW30mXLwCf3dGjBW2qLGkOJxGw5eu+aqwSiicocOKgjnEnU5cxwvLx/kkKS
 5UHyBrZwKT6D7Q=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:QBv96qo7H6d4lyyGOkjcuDgaV5u+L9V00zEX/kB9WHVpm5Oj+v
 xGzc5w6farsl0ssSkb6Km90KnpewK+yXcH2/hoAV7CZniuhILMFu1fBOTZslrd8kHFl9K1tp
 0QO5SWaueAa2SS5PySiGbXLz9K+qjkzEncv5a7854bd3AOV0gP1WdEIzfeNnczaBhNBJI/Gp
 bZzNFAvSCcdXMeadn+LmUZXsDYzue73q7OUFojPVoK+QOOhTSn5PrRCB6DxCoTVDtJ3PML7X
 XFqQrk/a+u2svLhyM0llWjo6i+quGRhOerN/b8y/T97Q+cyjpAUb4RFIFqegpF491Hpmxa0u
 Uk6C1QRPibo0mhBF1d5yGdkDUImQxel0MLxTKj8AbeiN28SzQgB8Vbg4VFNhPf9ko7pdl5lL
 lGxmSDqvNsfGf9dQnGlqr1vitR5z+JiGtnlfRWg21UUIMYZrMUpYsD/FlNGJNFGC7h8ogoHO
 RnEcmZvZ9tACWnRmGcunMqzM2nX3w1EBvDSk8eutaN2zwTmHxi1UMXyMEWg39F/pMgTJtP4f
 jCL81T5cZzZ95Tabg4CPYKQMOxBGCISRXQMHiKKVCiD60DM2Klke+F3Fz03pDbRHUl9upCpH
 2aaiImiYcbQTORNfGz
X-Talos-CUID: 9a23:v9EFT2FqtR1pow6FqmJJ+WRTP543dkbD0W3bHkqJEF9scICaHAo=
X-Talos-MUID: 9a23:LSMNcwuZwE5iOptb1s2ntTpfDc550fyVKGctiKs2osenOgZLNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,227,1787004000"; 
   d="scan'208";a="163599375"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGM4vnUWOZ6wsH55abID9mkmx4sWsaQNcXhsY?=
 =?us-ascii?q?qIMDwtScPu94VMJ1Zfzcd5Qx39WbeXTaCoylWBajH3e/VounuSV2hoco?=
 =?us-ascii?q?RlUCZ6nAaDO2qK9qoyOg8A8r5d6O18/UAQxHo7pPbjFjXJ0eHXa0AXTG?=
 =?us-ascii?q?CzHQWf14GcG78d3OXSX+ZSaA=3D=3D?=
Received: from mail-wm1-f72.google.com ([209.85.128.72])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:46:20 +0100
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a359b714f8so18785945e9.2
        for <cocci@inria.fr>; Mon, 23 Nov 2026 02:46:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795430779; x=1796035579;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0uCdHZiVVTDG+XttRZzpcPvSV82rXD7vMjRz82vFZNM=;
        b=MMSrQgj4g3tIvQ0LY9By8Jg5Z01jH7jz3lu0/JysGFLE/srikR2qHXMdcVhfWw/P+O
         L6QfHEwhAc1WtpmKtg30xP5pWU8+TGHTNmNLYascqlC2YLNySKY+kwz6p/rOEbyOqXcv
         4j21mcTPZpUrwVaqD7ul4E0I8JmrgytogR5m38JJP+k4DYWsyGnBebwFazS64+93txuB
         Jh1cNCn9SqsJuXeevxwupgOQJkXgT54evcuU5kZfAg8vih8N+r3f6jVXL4r6ROp3rtJ2
         0v/jJY1aAaXaX2sijrXDR3p656U6niwiPXRQRWIfhkAt0HikOr9Uakk672ZqNFUBA1iz
         RLYA==
X-Forwarded-Encrypted: i=1; AL+hErEU66lrHPegpQlPTFCTwIcSjQaK1KMa9diJUxJZYF7ocsyLkGIGVdPYqz8Wq/jPo+j4Ez+RGQ==@inria.fr
X-Gm-Message-State: APuU4Z8TbdQdfFXAOhiXvSzNjJ0JYRXVnVTwLEtSkEYekPCbnqhSHHWH
	eVjnNwNN6FnPnWfuwsqG70Jto+hkCJw5HzVrdU6Y/vmsNNYvyOSWObnRakKd0ANtLYRxt/ngGSK
	b2w==
X-Received: from wmdn12.prod.google.com ([2002:a05:600c:294c:b0:4bb:5ea0:79c])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4514:b0:4bb:6823:3d3c
 with SMTP id 5b1f17b1804b1-4bb888169d0mr241187105e9.20.1795430778882; Mon, 23
 Nov 2026 02:46:18 -0800 (PST)
Date: Mon, 23 Nov 2026 10:45:50 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123104616.226112-1-elver@google.com>
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-kernel@vger.kernel.org, cocci@inria.fr, kasan-dev@googlegroups.com, 
	Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v3] coccinelle: locks: Add must_hold.cocci
Reply-To: Marco Elver <elver@google.com>
X-Loop: cocci@inria.fr
X-Sequence: 3819
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/KGvQ2veiSFTknNF_7MPQFw>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Clang's context analysis treats lockdep_assert_held*() as an assumption
that the lock is held. A function that asserts instead of being
annotated with __must_hold() therefore passes the analysis, but its
callers are never checked.

Add a script that reports functions which assert on all paths that a
lock is held, where the lock can be named in a function attribute, and
which are not annotated with __must_hold*(), __releases*(),
__cond_releases*(), __context_unsafe() or __no_context_analysis. A lock
can be named if all identifiers in the lock expression are parameters or
member names, or if it is a global of the form &name or &name.member.
Functions that mention the lock before asserting it, e.g. to acquire it,
are skipped.

lockdep_assert_held() passes for any mode, so for it the script cannot
tell __must_hold() from __must_hold_shared() and reports both.

For example, on v7.4-rc2:

  kernel/locking/rwsem.c:396:1-20: rwsem_del_waiter() asserts &sem->wait_lock is held but lacks __must_hold(&sem->wait_lock) or __must_hold_shared(&sem->wait_lock)
  kernel/futex/pi.c:919:1-20: fixup_pi_state_owner() asserts q->lock_ptr is held but lacks __must_hold(q->lock_ptr) or __must_hold_shared(q->lock_ptr)
  drivers/nvme/host/fabrics.c:650:1-20: nvmf_lookup_transport() asserts &nvmf_transports_rwsem is held but lacks __must_hold(&nvmf_transports_rwsem) or __must_hold_shared(&nvmf_transports_rwsem)

Limitations:

 - Annotations on a prototype in another file are not seen; non-static
   functions are reported with "check prototype".
 - Annotations are detected textually and are not matched against the
   asserted lock.
 - Functions that require a lock without asserting it are not found.
 - Only lockdep_assert_held{,_write,_read,_once}() and
   assert_{raw_,}spin_locked() are matched; wrappers such as
   lockdep_assert_wiphy() are not.
 - Functions that test the lock expression before the assertion, e.g.
   __futex_unqueue(), are skipped along with those that acquire it.
 - &name.member is assumed to be a global.
 - Lock expressions that contain a cast are skipped.
 - spatch 1.3 fails to parse functions annotated with __cond_acquires*()
   or __cond_releases*(), so these are not checked unless a macro file
   defines these as MACROANNOTATION.

Cc: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/all/CANpmjNNM=qBJMvBkRu-WbhKA0hnkb_Bk8fyF9DTTsVmENDvZuQ@mail.gmail.com/
Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Also skip functions annotated with __cond_releases*() (Bart).
* Keep whitespace between words in the lock expression (Bart).
* Read each file once, and only record parameters of functions that
  contain an assertion (Bart).
* Document that casts and __cond_*() annotated functions are not handled.

v2:
* Report both __must_hold() and __must_hold_shared() for
  lockdep_assert_held() (Bart).
* Fix detection of annotations on prototypes in the same file (Bart).
* Make "forall" explicit (Bart).
* Skip functions that mention the lock before asserting it (Bart).
* Require all identifiers in the lock expression to be parameters or
  member names; accept &name.member as a global (Bart).
* Match parameter names and "static" in SmPL instead of with regular
  expressions (Bart).
* Also match lockdep_assert_held_once() and assert_{raw_,}spin_locked()
  (Bart).
* Document skipped attributes and further limitations.
---
 scripts/coccinelle/locks/must_hold.cocci | 149 +++++++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 scripts/coccinelle/locks/must_hold.cocci

diff --git a/scripts/coccinelle/locks/must_hold.cocci b/scripts/coccinelle/locks/must_hold.cocci
new file mode 100644
index 000000000000..a393d229d2bf
--- /dev/null
+++ b/scripts/coccinelle/locks/must_hold.cocci
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Find functions that unconditionally assert that a lock is held, but lack
+/// the corresponding __must_hold() annotation. The compiler's context
+/// analysis does not check the callers of such functions.
+///
+/// Only locks that can be named in a function attribute are reported: either
+/// all identifiers in the lock expression are parameters or member names, or
+/// the lock is a global of the form &name or &name.member. Functions that
+/// mention the lock before asserting it (e.g. to acquire it) are skipped, as
+/// are functions annotated with __must_hold*(), __releases*(),
+/// __cond_releases*(), __context_unsafe() or __no_context_analysis.
+//
+// Confidence: Moderate
+// Comments: Annotations on a prototype in another file are not seen; such
+//	     functions are reported with "check prototype". Annotations are
+//	     detected textually and are not matched against the asserted lock.
+//	     Wrappers like lockdep_assert_wiphy() are not handled, nor are
+//	     lock expressions that contain a cast. Functions annotated with
+//	     __cond_acquires*() or __cond_releases*() are not parsed unless a
+//	     macro file defines these as MACROANNOTATION.
+// Options: --no-includes --include-headers
+
+virtual report
+virtual org
+
+@initialize:python@
+@@
+
+import re
+
+# All of these imply that the lock is held on entry, or disable the analysis.
+ATTRS = re.compile(r'__(must_hold|must_hold_shared|releases|releases_shared|'
+		   r'cond_releases|cond_releases_shared|'
+		   r'context_unsafe|no_context_analysis)\b')
+
+# Parameters and linkage of the functions matched by rule r.
+params = {}
+static = set()
+# The most recently read file: (name, text, lines).
+src = (None, None, None)
+
+def key(pf):
+	return (pf[0].file, pf[0].line)
+
+def missing_must_hold(f, a, E, pf, p):
+	global src
+	k = key(pf)
+	# Drop whitespace, except where it separates two words.
+	e = re.sub(r'\s+(?=\W)|(?<=\W)\s+', '', E)
+
+	# Identifiers that are neither member names nor called functions.
+	free = re.findall(r'(?<![\w.>])[A-Za-z_]\w*(?!\w*\()', e)
+	if not (all(i in params.get(k, ()) for i in free) or
+		re.fullmatch(r'&\w+(\.\w+)*', e)):
+		return None	# Cannot be named in an attribute.
+
+	if src[0] != k[0]:
+		with open(k[0], errors='replace') as fp:
+			text = fp.read()
+		src = (k[0], text, text.splitlines(True))
+
+	# Attributes on the definition, or on a prototype in the same file.
+	hdr = ''
+	for l in src[2][int(k[1]) - 1:]:
+		hdr += l
+		if '{' in l:
+			break
+	if ATTRS.search(hdr.split('{')[0]):
+		return None
+	for d in re.finditer(r'\b%s\s*\([^;{}]*;' % re.escape(f), src[1]):
+		if ATTRS.search(d.group(0)):
+			return None
+
+	if a == 'lockdep_assert_held_read':
+		want = "__must_hold_shared(%s)" % e
+	elif a == 'lockdep_assert_held':
+		want = "__must_hold(%s) or __must_hold_shared(%s)" % (e, e)
+	else:
+		want = "__must_hold(%s)" % e
+	return "%s() asserts %s is held but lacks %s%s" % (
+		f, e, want, "" if k in static else "; check prototype")
+
+@r forall@
+identifier f;
+identifier a = {lockdep_assert_held, lockdep_assert_held_write,
+		lockdep_assert_held_read, lockdep_assert_held_once,
+		assert_spin_locked, assert_raw_spin_locked};
+expression E;
+position pf, p;
+@@
+
+f@pf(...)
+{
+	... when != E
+	a@p(E);
+	...
+}
+
+@prm@
+identifier f, x;
+type T;
+position r.pf;
+@@
+
+f@pf(..., T x, ...) { ... }
+
+@script:python@
+x << prm.x;
+pf << r.pf;
+@@
+
+params.setdefault(key(pf), set()).add(x)
+
+@st@
+identifier f;
+position r.pf, ps;
+@@
+
+static f@pf@ps(...) { ... }
+
+@script:python@
+ps << st.ps;
+@@
+
+static.add(key(ps))
+
+@script:python depends on report@
+f << r.f;
+a << r.a;
+E << r.E;
+pf << r.pf;
+p << r.p;
+@@
+
+msg = missing_must_hold(f, a, E, pf, p)
+if msg:
+	coccilib.report.print_report(p[0], msg)
+
+@script:python depends on org@
+f << r.f;
+a << r.a;
+E << r.E;
+pf << r.pf;
+p << r.p;
+@@
+
+msg = missing_must_hold(f, a, E, pf, p)
+if msg:
+	coccilib.org.print_todo(p[0], msg)
-- 
2.56.1.750.gf70dc682cf-goog

