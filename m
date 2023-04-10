Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1635C76196
	for <cocci@archiver.kernel.org>; Mon, 10 Apr 2023 13:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2tiUFoH9HRi0usALDkVxjS5BO1LIzDzfKthFO305XhI=;
  b=lSlP/HlR/efFTSOwpmDvq/LcCnkfK0HutD+NotFukZBffvHmgPxWxse/
   TGMnw0/D84nc/qRGrGFDVHnMVc73YAEgKWSAFTvtVw10a8pzCkkED7Wt1
   i+3uSMPu3/vqTgjtbyH3w3cgmCFUqIVMOvl/NCDtER2zVVgGz3e/ra5tL
   c=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,333,1673910000"; 
   d="scan'208";a="102273827"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Apr 2023 15:09:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A3A6AE7312; Mon, 10 Apr 2023 15:09:03 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 527C9E72F8
	for <cocci@sympa.inria.fr>; Mon, 10 Apr 2023 15:08:59 +0200 (CEST)
IronPort-SDR: 64340a69_ksAiWkw5Nphpib3602wzWGEQ6SCl7qzQtRYdWxe7N+meIus
 8uO5gil6jQPY2Xh4fnNiOcCLhsxvW43WRG/KN6g==
X-IPAS-Result: =?us-ascii?q?A0GIAABcCTRkhwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYItgUsvBAtGhFOVYIcuhz6Ia4FqgSw+DwEDAQ1BAQIEAQEDBDcBh?=
 =?us-ascii?q?EcChT0CHQcBBDMGDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQA?=
 =?us-ascii?q?QEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?gJHPgMDIwQZAQERJgEPCxoCJgICVwYBDAgBAYJ6gigBAzEHq0N/M4EBgggBA?=
 =?us-ascii?q?QacCx8sIlSBXgmBFC0BjQmDNnonD4FVRIE8glMwPh6EDRmDW4JnjmGLQwqBN?=
 =?us-ascii?q?HSBIA6BPIEEAgkCEWuBEAhqgXlAAg1jCw5vgUljTIF7BAIULSUEDgMZKx1AA?=
 =?us-ascii?q?gELOzo/NQYDCx8GWGsCCSMREwUDCxUqRwQIOAYcNBECCA8SDwYmRA5CNzMTB?=
 =?us-ascii?q?lwBKQsOEQNQgUcEL1x8CgYBJiSfXqRToWM0B4IqgVaBWQyfDQYTL5cJDgaSJ?=
 =?us-ascii?q?ZdzIKd/gXkkgVwzGiSDNk8DGQ+OIAwNCYQDj0g/ND0CBwEKAQEDCYVGAQGFf?=
 =?us-ascii?q?QEB?=
IronPort-PHdr: A9a23:Fvm+QhfXnf4oXUtAeCVK4K37lGM+o9TLVj580XLHo4xHfqnrxZn+J
 kuXvawr0AWUG9+LsbkZ1KL/iOPJZy8p2d65qncMcZhBBVcuqP49uEgeOvODElDxN/XwbiY3T
 4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx7xKRR6JvjvGo7Vks+7y/2+94fcbglWhDexe61+I
 RaooQnetsQbg5ZpJ7osxBfOvnZHdONayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU
 7FWFSwqPG8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XCmp4
 ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWWZNQsNdWipcCY2+c
 oQPFfIMM+VWoYbyqVQAsAWwCBeiBO3vyDBHmnD40LYm0+Q4CwzKwBAsEtwMvXnSsd77NL0SU
 eewzKTQyjvMdelW2TTg6IjTbxsvrvWMXbxqccrQz0kvGB7Og1KXp4P/JTOV1fkNs3OB4+RvU
 eKvhXQnqwB3ojig3cothJfGiZkPxl/Z6yp02YA4LsC3R0Bne9CrCodQtz2EOItsRMMvW29mt
 ig7x7AbvZO2cicExYgkyhPfZfKLb4qF7xHiWeufPTt1i3Jodayiihuv70Sty+7xW8qo3VtLs
 iZIk8fAu34L2hfO6caHUuNw8lm81TqRzQzf9P9ILEIumabGKZMt2KM8moQLvUnHESL6gkv7g
 LKMekgg5+Sk8efqb7vgq5SBLYF7kBv+Pb4rmsGnAeQ3LAwOX2+D9OS5073j4FH5TK9Ej/Ioi
 abVqo3VKtoDqq64BQ9azJoj5g6hAzu7ztgUh2cLIExHdR6dkoTkOUvCLO3mAfunhlSjijZrx
 /TIPr37BZXNK2DOnrD7crZn6E5c1REzwcpQ6ZJQBLEBOvPzWkn+tNHDAB42LRe7z/z6B9pjz
 o8eX3mADbeDMKzOqV+I+v4vI+6UaYMIoDr9MeQq5+byjX8lnl8QZbWm3ZwLZ3+kH/RrOF6ZY
 HrpgtcZC2gGpAs+TOrwiF2DSzFffXiyX7hvrg08XbynF4rYRsiOnbmIxm/vAJxMa3tGTFORF
 H7yX4GFXf4Wb2SVOMA31nQAVL68W8o50DmwuwLgjblqNOzZ/msfr52nnNt4/evekVQw/Dp1E
 8OHyEmTQGxu2GAFXTk72OZ4u0Mu5E2E1P1diuZbCMcbyvdHSAY8OtaI6uVgCM3pHC/FcM2IT
 lmOXdisRz08GIFii+QSalpwTo3xxivI2DCnVvpMz+Tj7P0c96vd2yO0PMNh0zPd07FniVA6Q
 8xJPGngh6hl9gGVCZSa216BmfOMcqIRlDXI6H/F1XCH6WRRSg1tSuPoWX4FZ03Zhcv07AXOQ
 uzmEqwpZzNI0tXKMa5WcpvshFRCSu3kPYH7aniyhnz2KBKG3LKKY6L1dm9b0CiOQFMcnVU1+
 nCLfRM7Gj/no2/aC2l2EknzZkr37eRkgHa8U1Ny0AyAKUFsv1as0jgSg/HUC/Ya37Zf/Twkt
 y0xB1GlmdTfF9uHoQNlOqRae9I0plldhyrfsERmM5qsIroH5BZWehlrv07oyxR8C5lR2ckso
 nQwyQNuKKWemFpffjKc1Jr0N/XZMG73tByobqfX3BnZ3rP0su8q4e47tk6lkQWnDEsk/F143
 tMT33bdrpTGAQwOUI7gB14t/ksyrLXbby8hooLMgCc1a+/u6GCEgo1vXbF2r3ToN81SO66FC
 gLoRsgTBsz1bfcvh0DsdRUceuZb6K8zOcqiMfqAwq+ieuh6z1fExSxK5p5w1kWU+m9yUOnNi
 twgyuubwxDBejPyllanvejolIoCaTxYTQ/dgWD0QZVcYKF/Z9NBLG60INCsgPh6iYTsXXFw6
 1OpQV8LkpzMG1Lafxn22gte0l4SqHqslH6jzjB6pDouq7KWwC3Ex+mKmAMvAmdQXyEiiF7tJ
 dPxlNUGRA2zaBBvkhK55EH8zqwdpaJlLmCVT10aNyTxKmhjVOO3uN/gK4Zq4YkrrD4RfeCye
 1GcRZbirhFc3y6rE2ZFxT89fi2nod2jxkY80jjCai8s6iODMchrjQ/S/tndWeJc0l9kDGFjh
 D/bC0L9d9il8NOIlovS5+W3VmavTJpWImHgyYKNsjf+5HU/W0Tl2arpxZu+Tk5ji3yetZEiT
 yjDoRfib5O+0q27NbkiZUx0HBrn7NI8HIhik4w2jZVW2H4Ah5zT82BU9AW7edhdx6/6a2IAA
 DARxNuAqi3swk5+NTSkw4zjV3OS6tRsbZ+2bylFv0B1p9APE6qS4LFeyGFQq0C7sBmXTPxzh
 DYbxtMx5XRcj+xD629Phm2NR7sVG0dfJynlkR+Fusu/oKtgb2GqabGs1UB6kIPpHPSYrwpbQ
 nq8ZoY6EHo68JBkKFyVmi6WiMmsaJzKYNkUrBHRjxrQk70fNscqjvRTzSt/ZTCn5CdjkbRky
 0U0g9fj5tjAcTgInurxAwYEZGesPYVJoG6r1PsYxoHMgsiuBskzQGxRGsGyErTxT3RK8q64f
 weWTG9m8yjdRuCZRF7Frh06/zWVQvXJfzmWPCVLnY8kHUfAYhUC0UZMG29k1p8hSlLwnZOnL
 x0/vGhOoAa/8EQEy/o0ZUOmDSGA/kHxO21yFsTYdkQzjEkK5l+JY5zEqLstQmcCpMzn9VfVY
 m2DO1YYVydQBBHCXQu7eOP0rZzJ9+zSbganB93JZ7jG6elXVvPTgImqzpMj5DGUcMOGInhlC
 fQ/nEtFR3FwXcrDyX0JTGQMmiTBYtT+xl/08zBrrs257PXgWR7+rYqJBbxINNxz+hewya6dP
 u+UjSx9JH5WzJQJjXPPzbEe2hYVhUQMP3G1Fq8csCfWUK/KsqpQEgJddC55csdFruo90gRLJ
 c/Hm4b127p/3ZtXQx9OUV3snN3sZNRfeTjncgmdWwDSa/Lff26uoYm/e663RLxOgf8BshSxv
 W3eCEr/JnGYkCGvURmzMOZKhSXdPRpEuYj7fAw+bAqrBN/gdBC/N8d6yDMsxrhhzFbDL20BK
 n5Rd01Xr7ufxTxViLNzFiYSixgtZfnBgCuf4+TCf9wOtuB3By1vi+9AyHE91qcT8yxOAvB40
 ni3zJYmsxStle+BzSBiWRxFp2NQhY6Fik5lPL3Q6phKXXusFPcl8miaTRgH9YMN4jLHpK1aj
 NTCxvubwNZq9tXJ4Y0DCsKSJM/VaBIc
IronPort-Data: A9a23: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
 RoiFrEc8/R/LlyFhQre2xBjvdpa+w==
IronPort-HdrOrdr: A9a23:ZF6GY6vO9+RrH7UpBmgiuzaA7skDotV00zEX/kB9WHVpmwKj5q
 WTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQouWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,333,1673910000"; 
   d="scan'208";a="52992275"
X-MGA-submission: =?us-ascii?q?MDGV1f6lIMmrQel5SbvCgAGoz80UTdi98mMqA0?=
 =?us-ascii?q?Q6i7TKRGO4sj27BrOFQHXnxJyKU+dUdwDHTwD/254vAbBpC+fcDj/P2i?=
 =?us-ascii?q?MS0PPIzh9kx3rbnMDtR5V6MFZYlAjMuDwhJJxfPlaTkcNvQZULqTTWg3?=
 =?us-ascii?q?cRKOlf2zPLFUS+G2nzTC0+dg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 15:08:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681132133; i=markus.elfring@web.de;
	bh=9xiZXXmbkkq78x3J0TEsq4uvNhOATwwu8ly4TXqKABI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jRlRt0IsKCHhIecE/GHdi7mtKXywMhyWj9h0KCS3CA2Jrn6datJo8kmKFNWZiKKJB
	 xe+h9SEKldcCxSIQAmv0LAf+RF9dIWLjtCI7r83HCnY5s/yFJpJ4WdLj+7Gdu5i3oE
	 Y1mYkTLhcuUhJCvCEZi0+g+SAu8jJeh5hfOd6JtOfH0m7UGXe7A75q3lNcZ/UQlV49
	 o2puD3gqqmHWoodltSIlm+9sTJsmNkBSL1XvU+vJFi81W9kuW+MLM2en/khhmsxFD7
	 Z+6ePbPUexMdZAPJpM2D2fEzkmF0xd6FgFsKCUoLMvwz4YzONNjulzZvlbhZ4H1y2j
	 N4VDVXNF46XvQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYcpt-1prCZ53brX-00VMsz; Mon, 10
 Apr 2023 15:08:52 +0200
Message-ID: <f9f40c8a-a392-27e3-b19c-c8985a163159@web.de>
Date: Mon, 10 Apr 2023 15:08:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
To: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <b3cce5b3-2e68-180c-c293-74d4d9d4032c@web.de>
 <2d125f3e-4de6-cfb4-2d21-6e1ec04bc412@web.de>
 <20230403033529.x6n3ihhkypwizq3b@vireshk-i7>
 <39342542-9353-6a7b-0aa9-f9c294b158cb@web.de>
 <20230403230432.xeubpa3cc2gt4mw3@vireshk-i7>
 <68b1988b-987f-fa2b-111e-b1b42f9767ab@web.de>
 <20230409235511.7xxqdxsqtflrhifk@vireshk-i7>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230409235511.7xxqdxsqtflrhifk@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lefAYnlVh+pAs3m3UZWd40T8/rlxuOkIjyhWAvUypOZ+Rp1+bmV
 g8tnfll5sl5fWfy/ILxZNhcYxIcWXt7/VPYnJbogH7TOowX7ae5hcmCQC8rXCdpjvewzP1U
 LbEhpil7G+lt6m97p8ZzwESh830SchrAVDeu5V9NYOJjIeFkPSsx4huGsVEAOTA4WebozPr
 MJWhvHRF5bVOtDlYPavDA==
UI-OutboundReport: notjunk:1;M01:P0:qySapMPXDXc=;UfOoLb/Kd3tt/yEtQeh0GS5go/n
 S+CU9jNZvXmyMJ8hmQk/jg3xIWWy1uZpZT+OQ+w/JmCs1DRnOXYJKlrZ+f7h21QOY2qwEYdaI
 9Dn/XFXHJZ0m1C8IETNE3lVKrtabE3qaRFWd0hMVp+eaE0XIUTSvfnR+eo9nqLOGTr6+/gB8t
 LJ7mGzM01Y6cm0nJ05xsxHnzPMU9C9WPKqzUqvrNzLf8p/HXY3Uf93F5JSn0PWg+Ay7Nqg3dV
 twjQjoushCrb1XmyRp799Fb320ImqImMYywHGI0H9njI86d+2NCuFiOPhpOjN5pBXGL7oXKUr
 Ibyq4WwB5WniyqPrqNxDitbG00Tfkch312Gu0zjH6CLS23eLZhRqxdBgZkNPHKRSIknGWbcAT
 w/BtdMeCo5dItPgWme4I1W7Q5IcdiBUFTfpB8LQtUbnoPuLqrbyjsNKaeBhCwoXhIjLghd2T3
 QNAIo9YYeuqsl+Gf//l/43PdD4UhJcGm7mlZcsLTvzc9cGTQWpeicUhwZGLPem5aoCH7rbpde
 FYNohw4BpfqYvu/txG3zjdr6S1/2NgWQ9DGp3JpnkdRHT0xavNv4zzfcB2LTsFF2joXC7t89m
 R41joW22HtCHtd8JZ1tUX9oUbQygVMz0raio5jDQNVZbTa3fv1srJdBwBGemR4jeaVjO0sZZz
 9TOaKqL/CtN1DouY+JlyIAcYmQPC+v4B9FYfQurcy+TFAHDVhEs9GEs2cuN6RNWt0q1vvrsDG
 MfY7PUs+8jl2h/Tm/LVamZ6aOnmwiyMYkachB/jxBT3jtutY6VOPgtAwDZcuwZ+qgWuHwPNjM
 9Z596rtmZ7YOgOgp0RJmjwWZie6ZA3GTOUY/vdMtqdwGSgO7W/jxrf4jmwoL4LL/ZPwwjqXcG
 /xSrY7xDvy3NPUB0Nbw/5jJf1l4HhfoYwo1CfoY71Jd2UfLwokqhFBlLi
Subject: Re: [cocci] [v2] cpufreq: sparc: Fix exception handling in two
 functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1023
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/f9f40c8a-a392-27e3-b19c-c8985a163159%40web.de>

>> @@ -337,21 +337,17 @@ static int __init us2e_freq_init(void)
>>  		driver->get =3D us2e_freq_get;
>>  		driver->exit =3D us2e_freq_cpu_exit;
>>  		strcpy(driver->name, "UltraSPARC-IIe");
>> -
>> -		cpufreq_us2e_driver =3D driver;
>
> This changes the behavior of the code here as "cpufreq_us2e_driver"
> is used in us2e_freq_cpu_exit(). If some failure occurs after a
> policy is initialized, and driver doesn't register successfully, then
> we won't set the frequency to the lowest index of the table anymore.

The setting of the variables =E2=80=9Ccpufreq_us=E2=80=A6_driver=E2=80=9D =
influences the need
to reset them to null pointers for the desired exception handling,
doesn't it?

Regards,
Markus
