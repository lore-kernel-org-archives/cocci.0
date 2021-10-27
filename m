Return-Path: <SRS0=/5U0=PP=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D025C433F5
	for <cocci@archiver.kernel.org>; Wed, 27 Oct 2021 16:19:09 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B1F60FBF
	for <cocci@archiver.kernel.org>; Wed, 27 Oct 2021 16:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B9B1F60FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AcgAgL6JlFQOyRObpFE+Rx5QlxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHC61Gl21DVUmGIaDzyHOvaJZDCmKNwnaI6+oEIA6J/VyoNqS1BcGVNFHysb8?=
 =?us-ascii?q?5KdbTi6Bh6tZH3KdpWroHqKXqzyU/GYRCwPZiKa9kjF3oTJ9yEmjPjQHOWkUoY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWHULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIsi?=
 =?us-ascii?q?0l67yNEwMWL/bewaU4pZUc/H40l4T/WprjPx9baREAatUo2zhc9RZw9JGvp31T?=
 =?us-ascii?q?hgvM7fkmeIHUhAeHTsW0ahuqOefeyDv2SCU5wicG5f2+N1lC0o9PKUR4O13AH9?=
 =?us-ascii?q?D77obJSoLYxTFgPi5qJqxS/J3l8otBMbuNYIb/HpnyFnxBvErR53Fa6rP7N5cm?=
 =?us-ascii?q?jw3g6hmEf/YIchfdjtraBXJZgZnNVIeCZZ4l+Ct7lHzeiNZpEmSo6Y57Gz7wwl?=
 =?us-ascii?q?40byrO93QEvSGSINOmVuKryTN+H70BA0bMvSQzDOE9jSngeqntSjgRYYWBZW38?=
 =?us-ascii?q?fllhFDVzWsWYDUcWF22rfi6lma+VtNZJgoO/SEttsAa/0isScLVXR2zpHmDpVg?=
 =?us-ascii?q?XXN84O+Ez7gCAzuzQ7hSSD24DZjpAbtU8s4kxXzNC/lSJhdLyGTt3sPufTn+d8?=
 =?us-ascii?q?6idqT+/IwARLGkIZDNCRgwAi+QPCqlbYgnnVsxkHOuxj8bpFCrtmmDMrS4khrx?=
 =?us-ascii?q?Vg9Rj6klyxnif6xrEm3QDZlddCt3rY1+Y?=
X-IronPort-AV: E=Sophos;i="5.87,187,1631570400"; 
   d="scan'208";a="800208"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2021 18:19:07 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C9543E0047; Wed, 27 Oct 2021 18:19:06 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E35F1E001C
	for <cocci@sympa.inria.fr>; Wed, 27 Oct 2021 18:19:04 +0200 (CEST)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=mansourmoufid@gmail.com; spf=Pass smtp.mailfrom=mansourmoufid@gmail.com; spf=None smtp.helo=postmaster@mail-ed1-f49.google.com
IronPort-PHdr: =?us-ascii?q?A9a23=3A1Rv0gBGR3XZDtkg3SZQb951Gf6JMhN3EVzX9CrI?=
 =?us-ascii?q?Zgr5DOp6u447ldBSGo6k31BmYBM6GtLptsKn/i+jYQ2sO4JKM4jgpUadncFs7s?=
 =?us-ascii?q?/gQhBEqG8WfCEf2f7bAZi0+G9leBhc+pynoeUdaF9zjaFLMv3a88SAdGgnlNQp?=
 =?us-ascii?q?yO+/5BpPeg9642uys55HfeQFFiCeybb5yLhi9sBncuNQRjYZ+MKg61wHHomFPe?=
 =?us-ascii?q?+RYxGNoIUyckhPh7cqu/5Bt7jpdtes5+8FPTav1caI4TadFDDs9KGA6+NfrtRj?=
 =?us-ascii?q?YQgSR4HYXT3gbnQBJAwjB6xH6Q4vxvy7nvedzxCWWIcv7Rq0vVD+886lkVgPni?=
 =?us-ascii?q?CYfNz447m7XjNBwjLlGqx6lvhBz3pLYbJ2QOPd4Y6jTf84VRXBZU8leWSxOAIO?=
 =?us-ascii?q?yYYUMAeQcI+hXs5Lwp0cSoRakGQWgGP/jxz1Oi3Tr3aM6yeMhEQTe0QInBd0Ot?=
 =?us-ascii?q?m/UrNLoNKcITOu7y67IzSjNb/NXxDj29Y/FchU7rvGKRrJwdtfRyVMqFwPCk1W?=
 =?us-ascii?q?Qp43lMC6O2+QCtmiU9etgVea1h2E7rAFxpyGiy8ExgYbGmowb0ErL9TllwIkrP?=
 =?us-ascii?q?924TlZ2bMOmHZZOqS2XNoR4T80+Tm10pSs31KAKtIK0cSUExpoqxBzSZvOIfYS?=
 =?us-ascii?q?U/x7uSPucLDZ6iX9hdryxhxa//VWvx+D6S8K6005KozJbntXQsn0BzR/e58idR?=
 =?us-ascii?q?vdj4kus2iyD2g/X5+xCPEs6j7DUK4Q7zb41jpcTsVrMHivxmEjuia+ZbEQk+uy?=
 =?us-ascii?q?x5+v5f7rqu4aQN4F7hwz6KKgulcu/AeM3MggKQWeX4/iz1Lrm/UHhQbVKiOM5k?=
 =?us-ascii?q?rXBvZzEOcgWorS1DgxV34o59RqzEzSr3M4XkHQDNF5FfQiIj4ntO1HAOvD4CvK?=
 =?us-ascii?q?/jkypkDhxwfDGJbrhAojXLnjGl7fhYLh9609BxwcowtBf4ohbCrAFIP7pRkDxs?=
 =?us-ascii?q?9nYAgcjMwOo2+bnFMl91oQGVGKLGKCYPrndsVuM5u80IuiMZYoVty3nK/c//fL?=
 =?us-ascii?q?ujHk5mUUcfaazx5cXZmq4FOx8I0qFeXrsnssBEWASswUiS+zllEGNUT9IanapX?=
 =?us-ascii?q?6M84yk7B5i8AYfCQICtmr2B0z2hEp1YfGAVQmyLRFX1c4SNE9MFdyuWJoc1kCE?=
 =?us-ascii?q?AVLHnT4Y+3BWqnA780btuaOTOrH42r5Xmgf184fbUiAt60DtpAcWRmzWIRmdvm?=
 =?us-ascii?q?X4SQjgr0qFziUN4w1aHl6N/hqoLRpRo+/pVX1JiZtbnxOtgBoW3A1qZFj9sYFm?=
 =?us-ascii?q?jS9SiRzo2S4BpqzfhS0l4EtSmyBvE2njza1f0v7mCBZhx/66FmnatdoByzHHJ0?=
 =?us-ascii?q?KRnhF4jEJMnCA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ac3YxrKvmg4GTFkRhsb9usRB27skD+NV00zEX?=
 =?us-ascii?q?/kB9WHVpm6uj5omTdZUgpGnJYVMqN03I9urwX5VoK0mwyXdK2/hYAV7PZniChI?=
 =?us-ascii?q?NHRLsSn7cL7VXbalnDH8RmpNddm5EXMqyEMbCR5fyKlzVQauxQs+Vvk5rY59s2?=
 =?us-ascii?q?rU0dLj2CMJsQnjuRYzzzeiYbJWl77LUCZdGhD6F81lydkBosH6CG71A+LpH+Tx?=
 =?us-ascii?q?yiruOYXfcBPXAawTjLqTup7brzFFyxxw4EVSxCzPML7AH+4nDEDirKiYDE9vaw?=
 =?us-ascii?q?7QXuB1A8oqqau6Z+7AvmsLlsW07Rtjo=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DXAQASaxphfzHQVdFagQmFUTsxhEePS?=
 =?us-ascii?q?YInim6BAIVrBYwGCwEDAQ1BBAEBhGECgmsCHQcBBDQTAQIEFQEBBQEBAQIBAwM?=
 =?us-ascii?q?EARMBAQ0LEAg4JoVoDYI1KQGDZAEBAQMSER0BGx0BAwwGBQsNAgImAgIiAREBB?=
 =?us-ascii?q?QEcBhMihSQBAy+bCIEEPYsygRUFF4EBgggGhGwKGSgNZQOBVwIHEn4qhCqCY4Z?=
 =?us-ascii?q?mJxyBSUSBS4JvPmsZAYZWgmQEhT7AOVqCWIE3C4IsmmQrg1MBoyG2RoUAECMSg?=
 =?us-ascii?q?UKBfTMaI4EBgjhQGQ6ON4NbinooLzgCBgsBAQMJiXUBAQ?=
X-IPAS-Result: =?us-ascii?q?A0DXAQASaxphfzHQVdFagQmFUTsxhEePSYInim6BAIVrBYw?=
 =?us-ascii?q?GCwEDAQ1BBAEBhGECgmsCHQcBBDQTAQIEFQEBBQEBAQIBAwMEARMBAQ0LEAg4J?=
 =?us-ascii?q?oVoDYI1KQGDZAEBAQMSER0BGx0BAwwGBQsNAgImAgIiAREBBQEcBhMihSQBAy+?=
 =?us-ascii?q?bCIEEPYsygRUFF4EBgggGhGwKGSgNZQOBVwIHEn4qhCqCY4ZmJxyBSUSBS4JvP?=
 =?us-ascii?q?msZAYZWgmQEhT7AOVqCWIE3C4IsmmQrg1MBoyG2RoUAECMSgUKBfTMaI4EBgjh?=
 =?us-ascii?q?QGQ6ON4NbinooLzgCBgsBAQMJiXUBAQ?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397548074"
X-MGA-submission: =?us-ascii?q?MDEFKLJewRCBS2q4vIhcsG5T1lathqGWi6RQhP?=
 =?us-ascii?q?XaoOB9maEL39RMhc5m8bxGZersCoDoKQFvqmzAvC2X+3HM5yYwLn7Nil?=
 =?us-ascii?q?u2g69qMROLy6suPJymTfw/4ecwmcBQcQJFOyImdCA27kyexq3hYvIIDD?=
 =?us-ascii?q?7d1MCc4zE3+vHa4gv8gTnVDA=3D=3D?=
Received: from mail-ed1-f49.google.com ([209.85.208.49])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2021 18:19:03 +0200
Received: by mail-ed1-f49.google.com with SMTP id y12so13430031eda.4;
        Wed, 27 Oct 2021 09:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yqJIyUz/uTgLff3tL3pMhJMGkbv3JCXzyV1ErdRGsYA=;
        b=ZV2lCZbHnWSVAaEXOHfINzs93heGXqeLZ3lpzcp9yNgdDMZRFyNwElqxub228fZBby
         ziK7F+nm3rW66lFHL3bdHd8XocnQ68QAaIcRE+vqAVBkmnSx2FyR0//f8TIfApY7oiiP
         r65SqM/QK15cDQuSTB332fEJYgscCAfsiffIBfwCB8XN/fN3fHOqUnki2W7pgZD22/ba
         sFxmhtaMz/iha07srSJZFDWXfAZ3qrG5JgkVUiW7zc+HM5tb2VtOQn0SWh95VaoCnAQH
         Wo+t5m/s2Ctm1QIwNtNzMbse6IVSelRhQjOV5dp5WhYKemgofFQZCKAKgTJo7+JMV+np
         nIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yqJIyUz/uTgLff3tL3pMhJMGkbv3JCXzyV1ErdRGsYA=;
        b=0kXWe37TmIGm0gW7kzuCkWGqf8G0/Nxs6izF8DMZx18QbGV1vSxlG53tRcMT1yVRk/
         IaI1k/eU9C7JCyfEvnCDFVI8kP4zbrJmPHGU+jKt/XDW9N0fbAO06nr797STmrs3aR8Q
         cjo1Q9YqrZJWvjsscG7yym7K6GjbcwDrruIR/NRN00bTKubQC0Wy8e8BxXaJfjgPnvmT
         6lrnPdqeuIF6bAo+ykA6UKklYiv4hqAOdgHZvM4zZCizqwF0dZtf0gh3Zsk24q+Q74WD
         xD1L6Nm/NeUorowCIghpm1ajIoY91Q2uCV8u/e/pTyvGgkeO7opFzH2HOOqiNCOYb1uV
         B+IA==
X-Gm-Message-State: AOAM530kOaIo3bMVvpE98jblxtpxlwOvIACu5o90oWSxAWT1EjeQZGxp
	IDwKaRaHI6875bFOA9VaCLGU6LRS4tPpgZx7yFYor1c/gUs=
X-Google-Smtp-Source: ABdhPJyOX53hhAiXRQre99IgIJkE1VQ7KrDSPW95HwhRN+TA28JzLn3qe0oZwAqkeZU3hfm8q/z77yL/ekTnIOwf4UU=
X-Received: by 2002:aa7:c0c5:: with SMTP id j5mr12421035edp.194.1635351543195;
 Wed, 27 Oct 2021 09:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <CALogXGULuKk=g58WyH4hBXeRr=epbnJ_n7pHeCbuoq_Q7h28-w@mail.gmail.com>
 <alpine.DEB.2.22.394.2110270723001.2966@hadrien> <CALogXGWiB_XwOZ5MsQe2qKu8ESDMYfRqTYg24ALZQF=sxkSi5A@mail.gmail.com>
 <alpine.DEB.2.22.394.2110271745200.2966@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2110271745200.2966@hadrien>
From: Mansour Moufid <mansourmoufid@gmail.com>
Date: Wed, 27 Oct 2021 12:18:52 -0400
Message-ID: <CALogXGVkE1V_9Whf6ZEYJf4k+3RSA-tYH8nxCP3c2E3_DESuvQ@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [cocci] Feature request: print status messages to the terminal
Reply-To: Mansour Moufid <mansourmoufid@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 44
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/CALogXGVkE1V_9Whf6ZEYJf4k%2B3RSA-tYH8nxCP3c2E3_DESuvQ%40mail.gmail.com>

On Wed, Oct 27, 2021 at 11:46 AM Julia Lawall <julia.lawall@inria.fr> wrote:
>
> --verbose-status ?

Sounds good to me. :)
