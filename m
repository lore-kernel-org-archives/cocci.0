Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CA7C43219
	for <cocci@archiver.kernel.org>; Wed, 30 Mar 2022 06:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=HjRkKcTIdEtSJ5qdAlFxYDjytEDuq9kJF/JdJHhM/W0=;
  b=nw8ZMlwjNX81lcw777D9IAhlQ5U0pFJdUT3cc6C+oKtW1ho7QHD1b6N3
   ZcgR/EXAS7jiYDNOqmHnXCy0e4esiWOK2CF4tyDEUNRNECHnnG/CXnuTX
   Sm8r0EaYtkRuWZKjV0t1M9SuGt0IwsbowuIs4/kIpniDzUyqdl6XuasVx
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@google.com
X-IronPort-AV: E=Sophos;i="5.90,221,1643670000"; 
   d="scan'208";a="29007508"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Mar 2022 08:39:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7919EE7D83; Wed, 30 Mar 2022 08:39:32 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8DCDEE7D80
	for <cocci@sympa.inria.fr>; Wed, 30 Mar 2022 01:48:43 +0200 (CEST)
IronPort-SDR: c+M1LVYKeC3vqit98igfKZlPUUyinlZoeX1X970KioD5G+JT3gc9BZ27xfvg13JXI8MzPJZ8J8
 BkcHf+ur2CNDAGcQ/+VjyCejSN2+9xLE6LEqRXq8PkksQhxL9ZlNNm/eh1Ik/18Y2peIVBFyM+
 qnzQ1cbLqOg/wUirIGZJRN9AIi80cByUQnpewn804dQG7+SjW8rOAJRN5KPLJbEWllAcgSf/Py
 JLq6MVDc+49AAjQdcWPr4SlTgiS/9qSnUag40kRsgeAlROfJkHbRnrqcGy1HsebpKDyMYAXBBD
 pYHJPGWJ6DbaOpPfVh28WluT
X-IPAS-Result: =?us-ascii?q?A0ANAABdmkNifzDaVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UYHAQELAYIngVQsBAtEhFSIJoh1ixKRU4ElA1QLAQMBDUMEAQGFBwKEUwIdB?=
 =?us-ascii?q?wEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBDQsJBwgKB?=
 =?us-ascii?q?w4OBT5kaIFPgXQLNA2CNSkBg2QBAQEDEhEdAQE3AQ8LCw0CAiYCAiEBEgEFA?=
 =?us-ascii?q?RwGEwgahUgDLqJcgQQ9izKBMYEBgggBAQaFEw1ngVwJEn4sAYYQgSeHEiccg?=
 =?us-ascii?q?UlEgUuCdD6CIUIChHqCQyKYdINPonydLmuDU4drkg+FezOoR4R0kWmQbJYLE?=
 =?us-ascii?q?COBPnWBIDMaCBsVbAaCMk4BAgECDQECAgMBAgECCQEBAo4dN4M7inwmMTgCB?=
 =?us-ascii?q?gsBAQMJkWABAQ?=
IronPort-PHdr: A9a23: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
 d/AkK+1IzBHoYu8wA==
IronPort-Data: A9a23:sDyZHqmdI2KfIXtm6fczQJvo5gyPIERdPkR7XQ2eYbSJt1+Wr1Gzt
 xIdXG2APayOa2X0L41ybI61/UsEv8SHn9ZgTVBkqntjRVtH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTres1hlZHWeIcg944f5Ys7N/09YAbeSRWVvX4
 4up+ZyHYjdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /1QrLuWQwMxZpTjhfkgfRcfGgN9ZPdZreqvzXiX6aR/zmXDenrohvhsVQQ4Yd1e9eFwDmVDs
 /cfLVjhbDjZ37PwkO/9ELA8wJhzRCXoFNt3VnVIwTXQEec+Ro7rTKLN6ttVmjw3g6iiGN6EN
 5tJM2MzM3wsZTV2An5INb0mw92RxSDcXAdek1O5vqUetj27IAtZieCxarI5YOeiTsJelUewv
 XPD522/AxcANdXZxyDtz563rurGnCe+VYBLUbPkprhlh1qcwmFVAxoTPbemnRWnolOnfPRVL
 1RMwwUzsJUc+guibNqkBQLt9RZooSUgc9ZXFuQ77iSExazV/xuVCwA4othpOIxOWCgeFWxC6
 7OZoz/6LWcw7+DNGBpx4p/R/GziY3FERYMXTXZcFVNt3jX1nG0kYvvyojtLFae0ipj4G2i1z
 Wza6ic5gLoXgIgA0KDTEbH7b9CE9sahou0dvF2/soeZAuVROtPNi2uAtwWz0Bq4BNzFJmRtR
 VBd8yRk0MgADIuWiAuGS/gXEbei6p6taWOA0QM/RsR9qmTzoRZPmLy8BhkudC+F1e5UKVfUj
 LP75Gu9GbcPZCv7NPcpC25PI51ykPW4fTgaahwkRoMWPsIZmP6v8yZpakqdt10BY2B9+ZzTz
 ayzKJ72ZV5DUfoP5GPvG481jOF2rghjmju7bc2ql3yPjOvFDFbIGOdtGAXUMogRsvjfyC2Lq
 IY3Cid/408AOAEISnKHr9B7wJFjBSRTOK0aXOQKL7baeVA3QTtJ5j246epJRrGJVp99zo/gl
 kxRkGcBoLYmrXGYewiMdF55b7bjAcR2oX4hZHR+MlGv1HwuJ42o6f5HJZcweLAm8s1lzOJ1H
 6ZZIZTeWqwXR2SV4SkZYLn8sJdmKEahizWIMnf3ezM4ZZNhG1HE94a8LAvi/SUDFAStss46r
 +Hy3w/XW8NbFQtlC8nSZbSkyFbo5SoRn+d7Xk3pJNhPeRWzrNI7dXSp1vJuepMCMxTOwDeex
 j26OxZAqLmfuZIx/fnImbuA89WjHdx4ExcIBGLc97u3aXTX82f/k49NVOGEIWLUWG/uov7wY
 OxUy7TxMqRCkgoa9YV7FLlvwOQ14N62/+1WyQFtHXPqaVW3C+M/fiPXg5EX7qAdlKVEvQaWW
 16U/oUIM7u+Ps64QkUaIxAob7je2PxIyCPe6+85fBfz6CNtpuHVVExTO1yBinUYIucldowix
 ugltYgd7Anm0kgmNdOPjyZ18WWQLyxfD/926MlCWIK72BA2zlxiYIDHDnOk6p+4bdgRYFIhJ
 SWZhfafirlRrqYYn6HfyZQQMSthaZUyVNRiyVYDIxGEmIOAiKNnmhJW9jszQ0JeyRAvPyef/
 IR0HxUdGElM124AaAt/s6SEFAZGCxmUvEf2zjPlUUXHGlKwWDWlwHIVYI6wEYNwz46YVjdc+
 76cxSDuVjOCkAQdGMctcRYNlsEPhuCdOuEPdA5L0ihF81QHjeLZv5KT
IronPort-HdrOrdr: A9a23:e8Pu2qFJn7GrxR+fpLqE18eALOsnbusQ8zAXPo5KOGVom62j5r
 iTdZEgvyMc5wxhPU3I9erwWpVoBEmslqKdgrNxAV7BZniDhILAFugLhrcKgQeBJ8SUzJ876U
 4PSdkZNDQyNzRHZATBjTVQ3+xO/DBPys6Vuds=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,220,1643670000"; 
   d="scan'208";a="28982147"
X-MGA-submission: =?us-ascii?q?MDHUS1eFqS0J5yvuv/UPS3azlOvi58ZDRWxBlg?=
 =?us-ascii?q?3CXXse1PVFW4fRvLrDuQcIfND+RDJR7xXjOHqBuD8aoRXZjX3DFUnsod?=
 =?us-ascii?q?JUShohjTyoNe7StfVpEgM/f8btDkQnmz6ochxphwZsSpN2EYpbROvXDE?=
 =?us-ascii?q?5o5yVe6dEU/VdamrJAt+9SqQ=3D=3D?=
Received: from mail-ej1-f48.google.com ([209.85.218.48])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 01:48:42 +0200
Received: by mail-ej1-f48.google.com with SMTP id r13so38205256ejd.5
        for <cocci@inria.fr>; Tue, 29 Mar 2022 16:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HjRkKcTIdEtSJ5qdAlFxYDjytEDuq9kJF/JdJHhM/W0=;
        b=Npg9tE2QGOUSet55NeMISOUe/KIPJ3btjDh/22dgXKu1PpUjyv7Vk4Y/oRPiEkY82w
         hcBWY3k/GnJzyqfD4xQV4QmOaihQ9S571CWdWE6Cu8zWij4iaT8ZVKe3C07i5W1s9yHA
         u4s+WgscKOGxKTYoLeUTkD75HZzK1F9xtclR9/zvyzyl8m6FfkdAbAJxj6cFf3Qy5Q6y
         BCC2yBo3UCRTBxjsP+uR8EWlc+sD8rIIGt0T5lBt4cOWoPSu3m+SUniVC/lX0MAT5zCl
         k6YdzBgp18h/6qfbpOIIuQ9CDuXGv22P10E/2zK5bCpdPdeAZVEvspBdUAunRZvcM3Wm
         mI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HjRkKcTIdEtSJ5qdAlFxYDjytEDuq9kJF/JdJHhM/W0=;
        b=bJmYpZY39OQWjjUUthQg34XxnpaZtRhvBlfMMetLVuACqkhfwyS/2e8LJvGPgFot+a
         6/FfJ+EwwkvBUq4jcC2zIVKeIjEjLBtHJBFP1O9stq5EcUg6fiujh2xl4YAUSC4E+j/P
         tGjWA804LYC2WTisgIBiPM3vw/UJK2tP3xeTzTTWX9cqoN2El5ROR0QCblfia0fh/OWT
         EDpGzTCf0dSDq8DvOh0q3AKIpgfRo5IVRC1MPGGYGH+kzx3rxmjuk4yiSGwsmwqXtnN8
         Mz9edyvdwuJEbgst+XdnjLrNIc6t+Q1wJx5CU9ODL8Hl3+83DecDEgBRiLZC7UMB82gy
         TEHg==
X-Gm-Message-State: AOAM532QoNyTr5rMiaGWudClao04cgLMUcg247w98V3z1AD1jF2C6Kkn
	wVilkJ5XbS5VNQRQWOlNZlvrUVVEyLYjqQXQwa/Mqw==
X-Google-Smtp-Source: ABdhPJzx3gWELIECgfbIZ7X/BnP3w6wKOVDzcjJ3/ACk+h5YKfJf8FHobuoDG15x3ba5Y2mpQHNA+QM/IqRkoW+athY=
X-Received: by 2002:a17:907:1622:b0:6df:d1a2:d4a3 with SMTP id
 hb34-20020a170907162200b006dfd1a2d4a3mr35877982ejc.542.1648597722027; Tue, 29
 Mar 2022 16:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648593132.git.marcelo.schmitt1@gmail.com> <9b8233e89227617a2cb47d85c654603c6583323d.1648593132.git.marcelo.schmitt1@gmail.com>
In-Reply-To: <9b8233e89227617a2cb47d85c654603c6583323d.1648593132.git.marcelo.schmitt1@gmail.com>
From: Daniel Latypov <dlatypov@google.com>
Date: Tue, 29 Mar 2022 18:48:30 -0500
Message-ID: <CAGS_qxoEZmAHVHQHJsnaALXmmODQono24qLbQr98FKqRUXmCNQ@mail.gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: corbet@lwn.net, mchehab+huawei@kernel.org, davidgow@google.com, 
	linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, cocci@inria.fr, 
	smatch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, dan.carpenter@oracle.com, julia.lawall@inria.fr
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 1/2] Documentation: dev-tools: Add a section
 for static analysis tools
Reply-To: Daniel Latypov <dlatypov@google.com>
X-Loop: cocci@inria.fr
X-Sequence: 310
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/CAGS_qxoEZmAHVHQHJsnaALXmmODQono24qLbQr98FKqRUXmCNQ%40mail.gmail.com>

On Tue, Mar 29, 2022 at 6:22 PM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Complement the Kernel Testing Guide documentation page by adding a
> section about static analysis tools.
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: David Gow <davidgow@google.com>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> Change log:
> - Brought generic tool characteristics to the intro paragraph
> - Made explicit that these tools run at compile time
> - Added a note of caution about false positives
> - Updated Coccinelle info to make it sound better and be more skimmable

This looks a lot nicer to me!
Thanks for doing this.

Daniel
