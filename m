Return-Path: <SRS0=woii=PS=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0137C433EF
	for <cocci@archiver.kernel.org>; Sat, 30 Oct 2021 16:30:31 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E452660FD9
	for <cocci@archiver.kernel.org>; Sat, 30 Oct 2021 16:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E452660FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3A2x0DVKOHGf6nbwjvrR20lsFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQftgj4r1TIGyWcfD23SO//bazP0f9kiatjj9kwBusOGm99gGjLY11k9FiMQ8?=
 =?us-ascii?q?ZKt6fexdxqrYXvKdqUvdK/WhiknQoGowPscEzmM+X9BDpC79SMljPnTHuKlYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5W31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFEcK?=
 =?us-ascii?q?gir+9c0sQQ7eUMxLmZnh+AvLyxEkZ4HVsiOBiaqJ0hUR/0l1lm/h6z95GtNm3V?=
 =?us-ascii?q?gEkJIXNnv4cWl9WCUmSOIUfou+XcCjj2SCU5wicG5f2+N1lC0o9PKUR4O13AH9?=
 =?us-ascii?q?D77obJSoLYxTFgPi5qJqxS/J3l8otBMbuNYIb/HpnyFnxBvErR53Fa6rP7N5cm?=
 =?us-ascii?q?jw3g6hmEf/YIchfdjtraBXJZgZnNVIeCZZ4l+Ct7lHzeiNZpEmSo6Y57Gz7wwl?=
 =?us-ascii?q?40byrO93QEvSGSINOmVuKryTN+H70BA0bMvSQzDOE9jSngeqntSjgRYYWBZW38?=
 =?us-ascii?q?fllhFDVzWsWYDUcWF22rfi6lma+VtNZJgoO/SEttsAa/0isScLVXR2zpHmDpVg?=
 =?us-ascii?q?XXN84O+Ez7gCAzuzQ7hSSD24DZjpAbtU8s4kxXzNC/lSJhdLyGTt3sPufTn+d8?=
 =?us-ascii?q?6idqT+/IwARLGkIZDNCRgwAi+QPCqlbYgnnVsxkHOuxj8bpFCrtmmDMrS4khrx?=
 =?us-ascii?q?Vg9Rj6klyxnif6xrEm3QDZlddCt3rY1+Y?=
X-IronPort-AV: E=Sophos;i="5.87,195,1631570400"; 
   d="scan'208";a="1288984"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Oct 2021 18:30:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DF83AE027E; Sat, 30 Oct 2021 18:30:28 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0892DE0072
	for <cocci@sympa.inria.fr>; Sat, 30 Oct 2021 18:30:27 +0200 (CEST)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=mansourmoufid@gmail.com; spf=Pass smtp.mailfrom=mansourmoufid@gmail.com; spf=None smtp.helo=postmaster@mail-ed1-f42.google.com
IronPort-PHdr: =?us-ascii?q?A9a23=3A49ZRYBT6miWWVGUpiqoDBPvCeNpsoj+fAWYlg6H?=
 =?us-ascii?q?Pa5pwe6iut67vIFbYra00ygOTBcOKsrkZ1KL/iOPJYSQ4+5GPsXQPItRndiQur?=
 =?us-ascii?q?oEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZ?=
 =?us-ascii?q?vJuTyB4Xek9m72/q99pHNfwlEnj6wba59IBi2rwjaq9Ubj5ZlJqst0BXCv2FGe?=
 =?us-ascii?q?/5RxWNmJFKTmwjz68Kt95N98Cpepuws+ddYXar1Y6o3Q7pYDC87M28u/83kqQP?=
 =?us-ascii?q?DTQqU6XQCVGgdjwdFDBLE7BH+WZfxrzf6u+9g0ySUIcH6UbY5Uim54qx1VBHnl?=
 =?us-ascii?q?jsINz8h8GHWlMNwir5boAm8rBB72oLYfZ2ZOOZ7cq7bYNgUR3dOXtxJWiNODIO?=
 =?us-ascii?q?zbYsBAeQCM+hFsYfyu0ADrQeiCQS2GO/j1iNEi33w0KYn0+ohCwbG3Ak4EtwJq?=
 =?us-ascii?q?nvUqs71NKAPUeCv0aLGyjLDb+5Y2Tf89YfDbxcsofSWUrJ2asrRzlQvFxnAjlW?=
 =?us-ascii?q?XtIzlMTKV2fkWvmiU6upvT+Ovi2o9pw5tpTivw94hh4/UjY0a1l7K7z92wJopJ?=
 =?us-ascii?q?dKmUk57Z8apHYZSuiyEKYd7Q8wsTm90tSom17ALp4O3cTQFxZkpyRDSaP6Kfoe?=
 =?us-ascii?q?H7B7/SeqcPSp1iXNndb+7iRi88UitxvDzW8SyzV1ErTJFn8HSunwR0xHf8MuKR?=
 =?us-ascii?q?/tn8ku/xTqC1Brf5+5aLU0yiKHVMYQuwqQqmZoWqUnDHjH5mEHxjKKOc0Ur4Om?=
 =?us-ascii?q?o6+D+brr4u5CQKpZ4ig/xP6gwgMC/DuM4Mg8BX2if5+uwzqHs/Ur8QLlSj/02l?=
 =?us-ascii?q?LfWsIzCKMgFuqK0BxVZ34Uj5hqlETuqzNcVkWMIIV5bYB6HipLmO1DKIPD2F/e?=
 =?us-ascii?q?/hFGsnS9ux//cOL3hGZLNLmXZkLfkerZ99kBcyAsuwt1E6JJUD6sOIPP3WkPrq?=
 =?us-ascii?q?NPYCRo5PxSuw+n7ENV9yp8eWWWXD6+dKqzTv0WH5uYrI+SXZY4VuTP9JOM/5/H?=
 =?us-ascii?q?0l3M5mFkdfbOo3ZQNcny4EO5mKV2DYXXwmtcBDXsKvg0mQeP2j12NTSJcZ3epU?=
 =?us-ascii?q?qIn5jA7DZqmAp3ZSoCshryBxia7EYdMamBIEFDfWUvvIqeZX/YFIAabPcZllnR?=
 =?us-ascii?q?QV6WlSoZn0RixvQv+47thNOvdvCMC48HNzt9wssjakwo16CY8KsOA3WCBBzVxl?=
 =?us-ascii?q?2UTQCIs2adir01x4liG2Kl8xfdfEIoAtLtyTg4mOMuEnKRBANfoV1eEJ4/RIL5?=
 =?us-ascii?q?DatqjCDA1CNk2xo1WC66cM9CrjxSG0ibzRrFJzfqEA5s79q+a1H/0dZ4VI5nu2?=
 =?us-ascii?q?6wojl1gScxKZzTOuw=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ajvjdq6H++P2smuXBpLqE18eALOsnbusQ8zAX?=
 =?us-ascii?q?Po5KOGVom62j5riTdZEgvyMc5wxhPU3I9erwWpVoBEmslqKdgrNxAV7BZniDhI?=
 =?us-ascii?q?LAFugLhrcKgQeBJ8SUzJ876U4PSdkZNDQyNzRHZATBjTVQ3+xO/DBPys6Vuds?=
 =?us-ascii?q?=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DaAQASaxphfyrQVdFaHgEBCxIMQIQwA?=
 =?us-ascii?q?YEgOzGER49JgiQDim6BAIVwjAYLAQMBDUEEAQGEYQKCawIdBwEENBMBAgQVAQE?=
 =?us-ascii?q?FAQEBAgEDAwQBEwEBDQsQCDgmhWgNgjUpAYNkAQEBAxIRHQEbHQEDDAYFCw0CA?=
 =?us-ascii?q?iYCAiIBEQEFARwGEyKFJAEDL5sIgQQ9izKBFQUXgQGCCAaEbAoZKA1lA4FXAgc?=
 =?us-ascii?q?SfiqEKoFGE0BKhmYnHIFJRIFLgm8+axkBhlaCZASEEz5RTDaTW6t4WoJYgTcLg?=
 =?us-ascii?q?iyaZCumdZYKoBwghQAQIxKBQoF9MxojgQGCOFAZDo4gF4NbinooLzgCBgsBAQM?=
 =?us-ascii?q?Jhy4sghsBAQ?=
X-IPAS-Result: =?us-ascii?q?A0DaAQASaxphfyrQVdFaHgEBCxIMQIQwAYEgOzGER49JgiQ?=
 =?us-ascii?q?Dim6BAIVwjAYLAQMBDUEEAQGEYQKCawIdBwEENBMBAgQVAQEFAQEBAgEDAwQBE?=
 =?us-ascii?q?wEBDQsQCDgmhWgNgjUpAYNkAQEBAxIRHQEbHQEDDAYFCw0CAiYCAiIBEQEFARw?=
 =?us-ascii?q?GEyKFJAEDL5sIgQQ9izKBFQUXgQGCCAaEbAoZKA1lA4FXAgcSfiqEKoFGE0BKh?=
 =?us-ascii?q?mYnHIFJRIFLgm8+axkBhlaCZASEEz5RTDaTW6t4WoJYgTcLgiyaZCumdZYKoBw?=
 =?us-ascii?q?ghQAQIxKBQoF9MxojgQGCOFAZDo4gF4NbinooLzgCBgsBAQMJhy4sghsBAQ?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397832823"
X-MGA-submission: =?us-ascii?q?MDEU6DtB0F7gdOMaVviry6ESUvnGPqot9Qi4Eh?=
 =?us-ascii?q?n5oozVNrEh7534iF03ovhLVix7Cz7lfA6+NLBRrF9qr8JzM2i19CalRP?=
 =?us-ascii?q?ipe8AxjSl6KMLKCm2EsS9GPUCYd9oDCH8t0WSLJt0OJXkZu8JLpGgbP2?=
 =?us-ascii?q?Xj4o/nB7zg3mpX88pp7H8Qqw=3D=3D?=
Received: from mail-ed1-f42.google.com ([209.85.208.42])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2021 18:30:25 +0200
Received: by mail-ed1-f42.google.com with SMTP id w1so30245068edd.0;
        Sat, 30 Oct 2021 09:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3UMV2IFeCoyI3r4geCTr4xAyaw2ss9wWgpaAlUNiaaE=;
        b=fccnAKStAEH8Sbzf2Udu+4QZK80zwdME2w68Cpw/GWa0//VpbB4FxnU6ulEDYQ19qB
         cfl6YgEEQOXqAYlVy+NS6a6corecYlWvr/cMDzi6Oyclxtt2AYHkZXPfhSQUhYAdNOhO
         Qmc0EYw18gl7AIJbb5FjiAmwczUhnsHULecZDNIoTIQ02Mx2sfkKX4ESDhwyg8EhKbYc
         t32FOz12aTafn7PJ5P973o0Zd1UCIccvI7jyhLQ5I7K4YueilNyHBqC4lPj1LqJgOCZS
         C/ajx7LzKfOiBqbjb+TcsZqaLXVd0T6ocbeFOtdR59ofNY5E3kGbA+dw1Nh64qIdq9eW
         GBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3UMV2IFeCoyI3r4geCTr4xAyaw2ss9wWgpaAlUNiaaE=;
        b=yzcaK7EypSMZJ2faLQCf9qRrRfJ/dvx9prHhRV+GlDokRN/P4iqhaPcCz4uUIAYVKa
         OH+luy1/OW/DD5/vfd8hCgSM6kri+GDUrlB1gXJAUMf9/XVO2qyPKfU/BHqwq6plcNaV
         ry+/rupqn9jMJ5jjYmMf62otCGXaC+lcZqSyXfhN8cFjiMikbskmq9kceBv38tje7z4/
         QmdbnrVky4Aj+FJXgCp5eLZfekde8VWFpLPVGpF2oIi3XMc2OOg9+FtayAsosHFABspx
         RoMUoTMUl0FbILtlBwzJf9TDPsFGW8GLUePQ0nXNxnjYb2kOP9+LXieCUx4DujCu8491
         8e/g==
X-Gm-Message-State: AOAM533z+y7kNBfe9mfAxQomi/JfvVy/rrxP8+o5TZpy39A3GxhOzlkS
	+kmA1Ud3A4OmXzOgYzw/SKTTYHhpiWDGiH+HPH0nI+n8i5A=
X-Google-Smtp-Source: ABdhPJzAuAm6obbUL7VVx2kdySSCWXI0zehuJC+69mnOwNmylkCvQFOPubhXRbZWv7WqC1bJI9YvhULV9Eb4hQNJRO8=
X-Received: by 2002:a17:906:9b89:: with SMTP id dd9mr22613167ejc.15.1635611424932;
 Sat, 30 Oct 2021 09:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <CALogXGULuKk=g58WyH4hBXeRr=epbnJ_n7pHeCbuoq_Q7h28-w@mail.gmail.com>
 <alpine.DEB.2.22.394.2110301135390.2946@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2110301135390.2946@hadrien>
From: Mansour Moufid <mansourmoufid@gmail.com>
Date: Sat, 30 Oct 2021 12:30:14 -0400
Message-ID: <CALogXGWJKs9TjoTxpGn_yQBsa2e4GhhhqyDFa4+VEFqzuzh+iQ@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [cocci] Feature request: print status messages to the terminal
Reply-To: Mansour Moufid <mansourmoufid@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 54
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/CALogXGWJKs9TjoTxpGn_yQBsa2e4GhhhqyDFa4%2BVEFqzuzh%2BiQ%40mail.gmail.com>

On Sat, Oct 30, 2021 at 5:39 AM Julia Lawall <julia.lawall@inria.fr> wrote:
>
> Hello,
>
> I'm still trying to understand what is the real goal for this issue, to
> see if it could be handled in some other way.  Do you want status messages
> to be separated from real errors?  Perhaps it would be sufficient to have
> an option that would put the status messages on standard out?  Then you
> could give the -o argument to put the generated patch into a file.

Sorry I didn't explain it well. I am using spatch in a script and
logging stderr to a temporary file to catch any errors. I just didn't
want the status messages to appear there because there are so many.
But I've worked around this by ignoring those lines. I don't think
anything on stdout should change. The current behaviour is fine, I
don't mind it that much.
