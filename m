Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610EBC433EF
	for <cocci@archiver.kernel.org>; Mon,  7 Feb 2022 14:24:13 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,350,1635199200"; 
   d="scan'208";a="20098210"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Feb 2022 15:24:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0E3A3E037F; Mon,  7 Feb 2022 15:24:11 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6BCFBE0380
	for <cocci@sympa.inria.fr>; Mon,  7 Feb 2022 15:24:09 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=efremov@linux.com; spf=Pass smtp.mailfrom=yefremov.denis@gmail.com; spf=None smtp.helo=postmaster@mail-pl1-f169.google.com
IronPort-SDR: n46JtxI69JkmoWeJClkBafJHAQVojRGdIfCiB5/3dn2sTM/LoNlXjUaND7Bvx7dUtqKTWgiPjQ
 JHJHDSPOOif0/O2jJ+Mj32LGvHADB79582gjfCM+XkOQ98CiCRdPXzYtcTQmvqkoEfNAXaCM20
 h6v3EzhPA0FgVYOqq8E3KLP7M/eDnsd+gS9cQ7eIkJxXAxcOCeKvd+0myPr1F0wnraqWBUJv0H
 6I4S/BfprK5mkx4k2F6VKAd7ozfysMgJR9qDU8Zpnu7X40TzdBvLH+OnUQCM24iQscDJ5qmuxg
 3LsHRSCl72oz6c97DedlP7cU
X-IPAS-Result: =?us-ascii?q?A0DxDQD0KgFif6nWVdFagQmBXIImgVUrBIUhiCiIcZIxi?=
 =?us-ascii?q?iOCBgEDAQsBARIvBAEBiGsCHQcBBDgCDQECBAEBAQEDAgMBAQEBAQEDAQEFA?=
 =?us-ascii?q?QEBAgEBAgMEARMBAQ0LCQcICgcODgVgAUVkgU+BdwgDAT2CNSkBg2QBBRIRV?=
 =?us-ascii?q?hALGAICJgICNAEFARwGDQgBAR6CYoMXBJ8xgQQ9ijh6gTGBAYl9CQEIfiuOM?=
 =?us-ascii?q?iccgg2BPIMDPmmGdBOCUgSWA48NkzpcngqDUIQNmz0GDwUug2ABkkoUgSWQK?=
 =?us-ascii?q?ZZKpkcCCgcGECOBbIFnMxoIGxWDJU0BAgEBAQ0BAgIBAgECAQIJAQECnG8+a?=
 =?us-ascii?q?wIGCwEBAwmQTwEB?=
IronPort-PHdr: A9a23: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
 h0V0fXzKoFBbuUTNGRtb1B7mMLBHE+CBLhw
IronPort-Data: A9a23:75IVGKqRASq9cMp4NRg1K2ulXNVeBmLQYxIvgKrLsJaIsI4StFCzt
 garIBmGMvyPY2b1LYgkO9nnpk0HvsWBzdEwSwtoq3w0RH8b9OPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKicfHkZqTZMEE/Nszo68wICqtMu0YjR7z+l4
 4uo+ZWFYAD9gVaYD0pNg069gEM31BjNkGhA1rAOTagjUIj2yhH5pLpGTU2AByOQrrt8RoZWd
 M6fpF2NxV41yj92Yj+TfhkXRWVRKlLaFVDmZnO7wMFOiDAazsA5+v5T2Pbx9S67hh3R9+2dx
 umhurSQFyEwII30u904bCh1CXFbPYZ3/5b+dC3XXcy7lyUqclPpyvRqSVkyZMgWo7gmR25J8
 vMcJXYGaRXra+CemurqDLkxwJ56cI+yYtJ3VnJIlVk1Cd43TJ7ZTqDN+5lU0TExnehBGP/fY
 4wSbj8HgBHoOUUXawdNUMxWcOGAiELnczt2hV6p9Ok0uzDSlQFvl6LNCY+AEjCNbZwNwhzwS
 nj912DwHRgeMPSNyD+P6Hvqh+nVnCq9Vph6PLa//fVrqEaCw3QaThwQT1qy5/ej4nNSQPpaI
 k0QvzIq9O08rRL6CNb6WBK8rTiPuRt0t8ds//MSyF+r07T02yWgI1c1YyQRTdwNhcgffGl/v
 rOWpO/BCTtqubyTbHuS8LaIsD+/URT5y0dSNUfoqiNVsrHeTJEPYgHnFYk8Tfbk5jHhMXShn
 GDQ9XlWa6A71JZTj82GEUb7byVAT6UloyYw7wTTG3qht0Z3PdD0IYOv7lff4LBLK4Pxori9U
 Josy5b2AAMmV8nleMmxrAMlQunBCxGtbme0vLKXN8N9nwlBAlb6FWyq3BlwJV1yLuEPciLzb
 UnYtGt5vcEPYCL6PP4vM9zrUKzGKJQM8/y1Bpg4ifIeM/BMmPOvoUmCmGbMhTm2yBF0+U3BE
 c3DL5vzZZrlNUiX5GPuG711PU4DySc5ymfeLa0XPDz2uYdykEW9EO9fWHPXNr5RxPrd/G39r
 ogCX+PXlE03eLCvOkH/rN9IRXhXfChTLc6t8KR/KLXTSjeK7Ul7VJc9N5t6K9I790mU/8+Ul
 kyAtrhwkgam1SaZeFnVNhiOqtrHBP5CkJ7yBgR0VX7A5pTpSd/HAH43e8RlcL852vZkyPIoH
 fAJd9/RUPtKQzXDvT8aaMCl/oBlcR2qgyOIPjakMGBvJc4+G1SR94+2ZBbr+QkPEjGz6pkzr
 rim4QXRHsgOSgFkO8DJZa/91Fi2p3UcxLl/UhKQcNlecUnh6qZwLCn1gqNlKs0AM0SRwjqcy
 hbQChAd/LGfr4gw+djPpKaFs4b2TLMjRBsERzHWtO/kOzPb82yvxZ57fNyJJT2NBnnp/KiCZ
 PlOy6ikYvcJq05QtI9nC7hmkPAl7Nz1qr4Fnwk9RCfXb06mA69LK2Wd2ZUdrbVEw7JUtFfkW
 k+L/dUGa7yFNNm/TAwULQshK/yHjLQaw2eDq/syJ0r+6Wl8+7/eCRdeOByFiSp8KrppMdN6n
 b1w5pZOswHv2AA3NtumjzxP8zjeJHI3Vah65IoRB5Xmi1Z2x1weM4bQDDT6vMOGZ9lWaBV4J
 zaVgO/ag+0ZyBOcIjw8En/C2ecbjpML4UgYwFgHLlWPu9zEmv5ng0ELoGpvFlxYnkddzuZ+G
 ml3LEkpd6+AyDFl2ZpYVGe2FgAdWRCU9yQdEbfSeLE1naVpaoDMEIH5EeOE/URc62YFOzYCo
 uDex2HiXjLnOsr220PenKKjR+PLFbRMGs/qwahL3Php27E1ZDPkhumlYm9gR97PH5YqnEOez
 QV11L8YVEA4XBL8Z4U/Co+HxfIbTxXsyKmuhx1+1PthIFwwsw1eFdRDx45dty+NyzH3HZeEN
 vFT
IronPort-HdrOrdr: A9a23:mX2Bjqz6cd6sg39hOv57KrPwD71zdoMgy1knxilNoNJuA7Wlfr
 OV7ZMmPHjP+UossRAb6K290ca7MBDhHPJOkPIs1PKZLXPbUQiTXeNfBOnZowEIcheWnoU96U
 4jSdkHNDSZNzZHZK3BkW2F+rgbsb+6GeyT9ILjJrRWID2CqZsL0+60MGqm+4RNKzV7OQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,350,1635199200"; 
   d="scan'208";a="20098206"
X-MGA-submission: =?us-ascii?q?MDGRFBz2fIYSoBpTL39s/RwqTRLeDgU9f1tZs5?=
 =?us-ascii?q?a6PazfF67rCaL8xTwbzA0Cp8M2NYNkmKeGVFbPzhl4EH5UywdMff5MwT?=
 =?us-ascii?q?qmjPFENfevZ3haEeXFaerfwgY+Qap/4itoYv6d4fgy2JvizvV2O/wMWs?=
 =?us-ascii?q?gFXJuNOdTK5DzYfoA37V66mA=3D=3D?=
Received: from mail-pl1-f169.google.com ([209.85.214.169])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 15:24:08 +0100
Received: by mail-pl1-f169.google.com with SMTP id k17so11283996plk.0;
        Mon, 07 Feb 2022 06:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cJlvR3lZzZ7oGQThAnOjecmTmkrrIcJtlYXiw0lOLBY=;
        b=oScGLeSRMWbLcTxGhe+1QhdipTPd8on9WlIcanrG88BDdL4M7iutdU/N4rjBJG3SPX
         JCST3As5uLaZfJGHAQtQ6PsSfP4JYwjlpN/1czsD8NSqC0ATPnfxWDuYy2oIE1qaU4/M
         27FbZw/CVFvnZBOOQ4jFFb4aKC9o5qxcAnYdf0Wozy9XUF23mBjY2fMdbfBjumtTOeuS
         QS6W7YH6BHwooIBhfzvZO2K4iaMHwzNNYPd27g6mcdi9iQ32aNn9bS265iWW7XjiHHsl
         KZhjxT5EssNm1rcnVclw0tf9IgXU5UrZb2hFxxD9WmBubuzutVBf4S1W/m8nuo2gq1fA
         dVfg==
X-Gm-Message-State: AOAM531EA0LbuDpZWo2AUCdV4uKU1SfSwWIKZA4BTJL2Pu/LgeG05abP
	v+V86IE2fbnqvxCg9RdJZM4vvty9SMc=
X-Google-Smtp-Source: ABdhPJxLQf5YDYol9hgrTFipf+0hs1Emb6/iyvz7LJXP9HkNibYEIZWFYtb37eTL/5HyvcC8bzLK3A==
X-Received: by 2002:a17:902:ced1:: with SMTP id d17mr11935194plg.37.1644243846162;
        Mon, 07 Feb 2022 06:24:06 -0800 (PST)
Received: from [10.68.32.40] (broadband-109-173-81-86.ip.moscow.rt.ru. [109.173.81.86])
        by smtp.gmail.com with ESMTPSA id 16sm12766926pfl.99.2022.02.07.06.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 06:24:05 -0800 (PST)
Message-ID: <ae6659cb-6ea1-2c75-616b-be1cbff9f30b@linux.com>
Date: Mon, 7 Feb 2022 17:24:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <cd9a37f0-9a90-1df5-cec7-853a783e5538@linux.com>
 <alpine.DEB.2.22.394.2202061941500.3126@hadrien>
 <f07ed61b-96e5-d99f-dc0f-d3f39b8291bf@linux.com>
 <alpine.DEB.2.22.394.2202062047220.3126@hadrien>
 <412f6138-c5de-38f4-553b-6b34a0650005@linux.com>
 <alpine.DEB.2.22.394.2202062158390.3126@hadrien>
 <efdc5e18-fdc4-56d6-f78e-0e47fe24ef02@linux.com>
 <alpine.DEB.2.22.394.2202070752260.3105@hadrien>
 <bb419c62-f560-e918-2eb2-94f489a93f4a@linux.com>
 <alpine.DEB.2.22.394.2202071053010.3105@hadrien>
 <d3e3961b-b0d5-6107-c14b-1e745ce1a631@linux.com>
 <alpine.DEB.2.22.394.2202071355350.52266@hadrien>
 <98066af4-1d26-dead-4e85-71ef0ec45d47@linux.com>
 <alpine.DEB.2.22.394.2202071514530.52266@hadrien>
From: Denis Efremov <efremov@linux.com>
In-Reply-To: <alpine.DEB.2.22.394.2202071514530.52266@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] spatch 1.1.1 segmentation fault report
Reply-To: Denis Efremov <efremov@linux.com>
X-Loop: cocci@inria.fr
X-Sequence: 140
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/ae6659cb-6ea1-2c75-616b-be1cbff9f30b%40linux.com>



On 2/7/22 17:15, Julia Lawall wrote:
> The fix should be available now.
> 
Thanks! I confirm that the problem solved.
