Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3DCC433EF
	for <cocci@archiver.kernel.org>; Thu, 31 Mar 2022 05:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=cHLGkaQYu4o1VuLVe04VP5C9UOK2Y5HybQ/7vFAycP4=;
  b=UIxC/s3sy8tosYC+JY99FRBuBDAHuGycJxXAtSQfALjFeZccJ6bfZGcw
   MgfW9KSsiIt6Eghvtw0MBAfzD3A+lcBGQ+hhmSi2VREvImEL6fcIDpBBl
   ur89O7IEV3wyguO3AXQdR21RvsRqnJn0CFkgTMkPw35PyB5Ftao8L8EtW
   c=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.90,224,1643670000"; 
   d="scan'208";a="29209679"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 31 Mar 2022 07:35:23 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B4CBBE1742; Thu, 31 Mar 2022 07:35:22 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C6BC4E00F6
	for <cocci@sympa.inria.fr>; Thu, 31 Mar 2022 06:14:47 +0200 (CEST)
IronPort-SDR: E1gkrzyzCs+XbVLNHW/d4xgCYs9CGOe9vAmButAZ8joU09sPKiQNAqPiJ9jRXru0MhS1rmic+Z
 lZNlf2pI7As6bBK8H1Z1fqyRVhvLfEeXcBy0cTdOw+1dw0m995CN8lkJAdkFOy/qTKo8XBOo/q
 WiT3I8B4zPxBxhtWQmpdhPaRemiPpKH1QL3RjHVLkagezO1mVfVk3NkV2HJxlFnxxMoz8g8sYA
 NcXAEsyBzryk5LKgdxYKIWO+O0uzHo5HGE5zRd3X1H6PVET+15+3ZpDvYbkm5tZC/W6u2UkSnX
 AEdGEiaEKqX5cCftIqf/LyLy
X-IPAS-Result: =?us-ascii?q?A0DfAQB0KkVifzPaVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VqCKDMBSlYsBAsXLYRUkRgDngoDVAsBAwENMxAEAQGFBwKEVwIdBwEENBMBA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQENCwkHCAoHDg4FYAFhA?=
 =?us-ascii?q?wFEgU+BdAsDBAYnDYI1KYNlAQEBAxIRBBkBGx0BAwwGBQsNAgImAgIhAQERA?=
 =?us-ascii?q?QUBHAYTIoJjgmQBAy6hLoEEPYsyfxYFF4EBggkGhEkKGSgNaoFZAgcSfiyES?=
 =?us-ascii?q?YFIgSeHEiccgg2BFTaBBoFuPoFTToU+gkMiBJgrPzMBUygTARMXIQIyIFlHk?=
 =?us-ascii?q?kgUkB6cbkNrFUqCdIQVhnuOa4V7M4VDowmEdJFpjRiDVJBsC4UVECMSgUNeg?=
 =?us-ascii?q?SBwgQGCOAlFAQIBAQENAQIBAQMBAgECCQEBAowugW8MFhWDO4RZhhI3MTgCB?=
 =?us-ascii?q?gsBAQMJkWABAQ?=
IronPort-PHdr: A9a23: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
 xQM3NLsSLdYjr8mfmdu2le0hA==
IronPort-Data: A9a23:LS1L5qAmQGaaDxVW/+Hlw5YqxClBgxIJ4kV8jS/XYbTApGtx1zBTx
 2AeDDuPM63ZNDTyKNh+b4zl9EpQsJ6Dm9FiOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFw0XqPp8Zj2tQy2YPiWlvU0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYoyyrwddu1
 +hUj62bSAUOYanPnsUWcxYNRkmSPYUekFPGCX22sMjWwk+fNnWxmrNhC0Y5OYBe8eFyaY1M3
 aZAeXZdM1bZ3rLwnevTpupE3qzPKOHuIY8YvH5kzDjfAv8sSpzrTKDD5Nse1zA17ixLNayPP
 ZJDNWs0BPjGSzRsHW4cEssjp7qphUX1KXpxsliOuoNitgA/yyQoiOS3WDbPQfSBQs5en26Dt
 2fe9iL4BAsbPZqR01Kt9nuzj+vLtTH6XYgIHfu58ORriRud3AQu5AY+UFK6pby0iBf7VY8Gb
 UMT/SUqoO4580nDosTBswOQuVzauQEDZsNqIsY76ibSzqnSwg25CT1RJtJeU+AOuMgzTD0s8
 1aGmdL1GDBi2IF5r1rNpt94ShviaUAowX8+iTwsFlRavoGyyG0npleeEYY5Sf/dYsjdQGmom
 1i3QD4Ca6L/ZPPnOo2+9FHDxj+u/93HE1dz6QLQUWaoqAh+YeZJhrBEC3CLs56sz67DFjFtW
 UTofeDAsYji6rnTyUSwrB0lRu3B2hp8GGS0baRTN5cg7S+x3HWoYJpd5jpzTG8wbJpUJ2G0O
 BeL5FoIjHO2AJdMRf8nC25WI5R6pZUM6fy4PhwpRoYWMskoLFHvEN9GPBbNgjiFfLcQfVEXY
 M/HK65A/F4VDqNoyDfeegvu+e5D+8zK/kuKHcqT503/j9K2PSfJIZ9YbgbmRr1mtMus/VSNm
 /4CZpDi40gOAIXWPHOLmaZNdgtiBSZgVfjLRzl/LLHrzvxOQzF/VZc8ANoJJ+RYokiivryWp
 ivkAB8JlQKXaL+uAVziV02PoYjHBf5XxU/X9wR2Vbpx83R8M4up8okFcJ47Iesu+OB5nKx7S
 vAEf4OLBfEWEmbL/DEUbJ/cqo1+dUTz1VjeYXb9ODVvLYR9QwHp+8P/elS9+SQLCB2xv5Rsr
 rCl0DTdXpdeFR9pC9zbaa70wl7o5Sodlet+UlHmON5WfEmwooFmJzag3PAyKsAIbx7Ew2LCh
 QqRBB4Zo8jLopM0oIGZ3/Da89/xHrInTERAHmTd4bKnDgXg/zKukd1aTeKFXTHBT2erqqivY
 ONiyfujYvAKmVB9tZUlT+RmwKc40NvYp7FAyzNiEniWPU+gDaltIyXf0MRC6v9Ny7tetVfkU
 06D4IMBa7CAOcegHVxIYQR4N6KM0vYbnjSU5vMweR2o6Chy9buBcENTIxjc13AHfeUtaNsok
 bU7pcobyw2jkR52YNyIuSZZqjaXJXsaXqR765wXXN3xhgwwxg0QaJDQEHWtspSGatEJP0tzZ
 zHJ3ezNgLNTwkeEeH02TCCf0e1YjJUImRZL0F5SeAjTy4Sd3qc6jE9L7DA6bgVJ1REbgeh9D
 W5mah9uLqKU8jY02cVOUghAwe2a6MF1J6Aw97cIqIEdZ0yhV2iIIW9kfOjQpQYW9GVTejUd9
 7adoIogvfAGY+mpthbem2Y8wxAgcTC13gLHkcGjWc+CGvHWpBL717S2azNgRwTPWKsMaY6um
 QWu1Ol1YKz/cyUXpsXXzmVcOas4EHi5GYCJfR2tEG7l040RlPFeFAVi83yMR/4=
IronPort-HdrOrdr: A9a23:8vOw7KvI5QvJSpej9OniSMy77skDSdV00zEX/kB9WHVpmwKj5r
 mTdZUgpGfJYVMqMk3I9urwXZVoLUmsl6KdpLNhXotKPzOGhILLFvAH0WKK+VSJcBEWtNQ86U
 4KSdkYNDSfNykdsS842mWF+hQbreVvPJrGuQ4W9RlQcT0=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,224,1643670000"; 
   d="scan'208";a="29202493"
X-MGA-submission: =?us-ascii?q?MDHK2NGJjERYU4kdQ75osppqnZROnUbX8VdaLF?=
 =?us-ascii?q?bcecETL770vW6D2frfE2oP/TP50OvCDyxUm3acf53KkWKphpgXS6NQas?=
 =?us-ascii?q?uvDlAYWeYpKWNot3NFFV2syeglDKkwFZF8MBiWNO1q5zQMWYFZuuGEyu?=
 =?us-ascii?q?NSs+EnAqe5tFJQhtjK1qeMZQ=3D=3D?=
Received: from mail-ej1-f51.google.com ([209.85.218.51])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 06:14:46 +0200
Received: by mail-ej1-f51.google.com with SMTP id p15so45443373ejc.7;
        Wed, 30 Mar 2022 21:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cHLGkaQYu4o1VuLVe04VP5C9UOK2Y5HybQ/7vFAycP4=;
        b=IejV0elzv/fR5v4FKPqWNBF8faVRUyD4+g73zFNzDj84EhCzmnV+cYKflwLA4Otjfi
         VtFOlbHiTPkKvxrwAoDgW53yCHYhQKLJktKQclamHJcHFen5tWhCTdc51fR0fCQxbv92
         dNAYMM275Is6y+5unL7BXYt5RP4MunPV3xMDYp9cgc/vOJGyWud0IsknBQVLOpbSnUHV
         5dDeGZ1Dn3kb/K8CpwisW5DiEaBGUJGNpTwjy3oha1/ImqmlAhyrc6TRaDNh+YEBxHbc
         K7QrSfpP6hKCiv4ttnd7bzOLXob/N2aHt1fzc4xSEcz3LTqwedqPL6O1ONAEBwPc7HGl
         p42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cHLGkaQYu4o1VuLVe04VP5C9UOK2Y5HybQ/7vFAycP4=;
        b=AJ4W4pp7EXt1eTNEEDH2qilwgzdmwpC8FNWuDEV+wa/GhMreTMhLj8iWaTao3CX0To
         di5pTcynVay8y1iPvowzbIPfy+NlxNpTjb0numNZq7zIk+ZGyuDYjLus8uA/8xy16n/y
         BEysCiWZUgs780q/kA/8pJa1whaTA6tEsnap6snG4wm8LQcUYBCMS0KS2FKehG/8AvHL
         0ovYX7znKQ2oNPEQMcM0GI63qmm6cPmqJUT+CSy+8l2uBD9vPmZm11uJNLpLVz0gZOyw
         LcA5i0F3jddUY2Ayn0lc0fVECwv3AkPw/paxKuf6IzGEMecPwV0c29Vl0wnb2hVcM7+M
         0sDQ==
X-Gm-Message-State: AOAM531jnijG7NsD7jpg0PsnNFFhvY68z1LVe/is7lkvMEF26q12Thlz
	HfjDYad1DSfmaE+EHcBIYB+T0XeLJDbNZdlqAX8=
X-Google-Smtp-Source: ABdhPJylV+qIHEhgIiC8pc2ZyVs4dIvULSo9dP3vfdc/QTV15d7mrqgXEUvxiupeD7GQsWsqPD8b71wB8duOxbnPqTU=
X-Received: by 2002:a17:906:3a15:b0:6cf:ea4e:a1cc with SMTP id
 z21-20020a1709063a1500b006cfea4ea1ccmr3304474eje.753.1648700086306; Wed, 30
 Mar 2022 21:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648674305.git.marcelo.schmitt1@gmail.com> <7d793c1b9f87d9cb8ac0e858e561e108c2bf0176.1648674305.git.marcelo.schmitt1@gmail.com>
In-Reply-To: <7d793c1b9f87d9cb8ac0e858e561e108c2bf0176.1648674305.git.marcelo.schmitt1@gmail.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Thu, 31 Mar 2022 12:14:19 +0800
Message-ID: <CAD-N9QVvgCqbwiebjVX2_81pH_YhK+j4hhJPG3fbWbAtzFVJTQ@mail.gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, dlatypov@google.com, 
	davidgow@google.com, linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, 
	cocci@inria.fr, smatch@vger.kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>, skhan@linuxfoundation.org, 
	Dan Carpenter <dan.carpenter@oracle.com>, julia.lawall@inria.fr
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v3 1/2] Documentation: dev-tools: Add a section
 for static analysis tools
Reply-To: Dongliang Mu <mudongliangabcd@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 321
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/CAD-N9QVvgCqbwiebjVX2_81pH_YhK%2Bj4hhJPG3fbWbAtzFVJTQ%40mail.gmail.com>

On Thu, Mar 31, 2022 at 12:07 PM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Complement the Kernel Testing Guide documentation page by adding a
> section about static analysis tools.
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Julia Lawall <julia.lawall@inria.fr>
> Reviewed-by: David Gow <davidgow@google.com>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> Change log v2 -> v3:
> - Added Julia's acknowledgment tag
>
> Change log v1 -> v2:
> - Brought generic tool characteristics to the intro paragraph
> - Made explicit that these tools run at compile time
> - Added a note of caution about false positives
> - Updated Coccinelle info to make it sound better and be more skimmable
>
>  Documentation/dev-tools/testing-overview.rst | 31 ++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
> index 65feb81edb14..b5e02dd3fd94 100644
> --- a/Documentation/dev-tools/testing-overview.rst
> +++ b/Documentation/dev-tools/testing-overview.rst
> @@ -115,3 +115,34 @@ that none of these errors are occurring during the test.
>  Some of these tools integrate with KUnit or kselftest and will
>  automatically fail tests if an issue is detected.
>
> +Static Analysis Tools
> +=====================
> +
> +In addition to testing a running kernel, one can also analyze kernel source code
> +directly (**at compile time**) using **static analysis** tools. The tools
> +commonly used in the kernel allow one to inspect the whole source tree or just
> +specific files within it. They make it easier to detect and fix problems during
> +the development process.
> +
> +Sparse can help test the kernel by performing type-checking, lock checking,
> +value range checking, in addition to reporting various errors and warnings while
> +examining the code. See the Documentation/dev-tools/sparse.rst documentation
> +page for details on how to use it.
> +
> +Smatch extends Sparse and provides additional checks for programming logic
> +mistakes such as missing breaks in switch statements, unused return values on
> +error checking, forgetting to set an error code in the return of an error path,
> +etc. Smatch also has tests against more serious issues such as integer
> +overflows, null pointer dereferences, and memory leaks. See the project page at
> +http://smatch.sourceforge.net/.
> +
> +Coccinelle is another static analyzer at our disposal. Coccinelle is often used
> +to aid refactoring and collateral evolution of source code, but it can also help
> +to avoid certain bugs that occur in common code patterns. The types of tests
> +available include API tests, tests for correct usage of kernel iterators, checks
> +for the soundness of free operations, analysis of locking behavior, and further
> +tests known to help keep consistent kernel usage. See the
> +Documentation/dev-tools/coccinelle.rst documentation page for details.
> +
> +Beware, though, that static analysis tools suffer from **false positives**.
> +Errors and warns need to be evaluated carefully before attempting to fix them.

Hi Marcelo,

Should we include static analysis tools based on LLVM? For example,
Clang static analysis.

> --
> 2.35.1
>
