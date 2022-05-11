Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F278BC433FE
	for <cocci@archiver.kernel.org>; Wed, 11 May 2022 19:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=TEMnhS35hmL6U2utZ54EREZjtXOHvGxxfla3N0eQ/Ks=;
  b=D1EeLo/ppj3aw974/OeQtC8xzY9Xoa/DxJxOX2ecCPzYWyXnWN+A+MQt
   /5SUFt+MqKk1Q5V2/o2aTrGEM4R8+0CIhWfwU8RVevND5qCLVbco8hKH8
   2L7kw+GWeAdCpGfcqGI+EVIewEcqfDhVwUO4pSV21rNUJKzLV+H/NuFKo
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.91,218,1647298800"; 
   d="scan'208,217";a="35831359"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 May 2022 21:54:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A7A4EE0265; Wed, 11 May 2022 21:54:31 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D1F13E0098
	for <cocci@sympa.inria.fr>; Wed, 11 May 2022 21:54:24 +0200 (CEST)
IronPort-SDR: 9WoIC2aZVcogw3BY/QtAXS6PMqIpo4kDCcQJx2Z/j7RZoKv9f+DvwyYDSpDyGBV0Vw0KwW/BJQ
 dc2oEaY8DX9hs7Zzn4gXBWPvvUQR/u9sRV7vOULUJxEbC+pQsOk3BHpwSUKhS9L6Cd7oZZ7KRj
 zExe3YW3DlD1t1RhrirJ5/hkHssYjiuNNjGg1Sm7r0rUeHfYAj64rZf+lzCQrA4nQigYeDLITb
 lcFBUD06OwMUS0rzMP2zxRC7QIZMkLMj18GSYoRSDCnr+cl04j+zhKh8tbfleKOb5ZhqfYPyln
 NFP2CTmyC5FZ7KxjYVXrMbFa
X-IPAS-Result: =?us-ascii?q?A0CvDQD7E3xihwwR49RaglqCIoFTLQQLQ4ROjmaCKIsnh?=
 =?us-ascii?q?xqKI4F7CwEDAQ0/AQIEAQGFAgJ2AYRHAh0HAQQ2BA0BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAwEBBQEBAQIBAQIEBAETAQEBDA0JBQgKBw4FCwU2Bl4GZASBSwSBdAs0D?=
 =?us-ascii?q?YI1KQGDWgoBAgIBIx0BAREmAQQLCwMBPgICVwYNCAEBgnmCYwEDDSipe4Exg?=
 =?us-ascii?q?QGCCAEBBoRKHywiUoFcCYE9hzoBhyQnEIFVRIE8DIJ3PoQiAQGDdoJllVYHJ?=
 =?us-ascii?q?wQPAx04gQYSgSFxAQoGAwMHCgUyBgIMGBQEAhURUx4CEwUHChwOFBwkGQwPA?=
 =?us-ascii?q?xIDEQEHAgsSCBUsCAMCAwgDAgMjCwIDGAkHCgMdCAocEhAUAgQTHwsIAxofL?=
 =?us-ascii?q?QkCBA4DQwgLCgMRBAMTGAsWCBAEBgMJLw0oCwMUDwEGAwYCBQUBAyADFAMFG?=
 =?us-ascii?q?wwHAyEHCyYNDQQcBx0DAwUmAwICGwcCAgMCBhcGAgJyCigNCAQIBBweJhMFA?=
 =?us-ascii?q?gcxBQQvAh4EBQYRCQIWAgYEBQIEBBYCAhIIAggnGwcWGR0ZAQU3JwYLCSMcC?=
 =?us-ascii?q?hQQDQYFBhYDJy4GIgEdUo9HhzmCGYFZwHQ0B4IRgTuBQQyeIwYTLZZKDgaRd?=
 =?us-ascii?q?ZZjpyKBewmBcjMaJE+CaE4BAgECDQECAgMBAgECCQEBAo42hAyKLT80OwIGA?=
 =?us-ascii?q?QoBAQMJhUcBAYc+AQE?=
IronPort-PHdr: A9a23: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
 XmLxjaLi06rmK+Dx2g/OCc=
IronPort-Data: A9a23:ilpRDKxD369T4MY7sZV6t+c9wCrEfRIJ4+MujC+fZmUNrF6WrkUHy
 DEZCD/UbPjYYGv3fIogYNi3p0pTsJbTnd9nGwRurlhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefQAOCU5NfsYkidfyc9IMsaoU8lyrdRbrJA24DjWVvQ4
 Iqq+KUzBXf8s9JKGjJMg068gEg31BjCkGtwUosWOJinFHeH/5UkJMp3yZOZdxMUcaEIdgKOf
 Nsv+Znilo/vE7jBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPhDk
 Mdms7+eZD4lO52LvNkXCTJdHT1xaPguFL/veRBTsOSWyFDaNWThybNiASnaP6VCo7wxWzsRs
 6VHbmlXBvyAr7reLLaTb+B2hdk4auTvMpkevH5I0jzTS/orKXzGa/6XtYQBh29p7ixINaedS
 Mk8ZhRKVTD7QCJ9Ew8GOpF93+j90xETdBUB9Q7L/PNpi4TJ9yR617PmMfLOa9mSTINUmFyZr
 yTI5QzE7goyMduC1Xya/3jqiuKncT7HtJw6JuWq3fhJrnCqymkjTzkrXwGQpPelhRvrMz5AE
 HA89i0rpKk00UWkSNjhQhG1yEK5Ug4gt8l4TrVmtlrQokbAy1nGXThUJtJUQIZ+7KcLqSoWO
 kihs/6B6dZHirSTUniU/bfRhzqvPCIcJm9qicQsEFVfuISLTG0btBLCT9BnGai5y+X7EDXiq
 w1mQQA7gKgPy9EG3eO38DgrYg5ARLCZEGbZBS2OAApJCz+Vgqb7PeREDnCFt559wH6xFAXpg
 ZT9s5H2ABoyJZ+MjjeRZ+4GAauk4f2IWBWF3wM1Rch6p2/xpST+FWy13N2YDBg4WirjUWC4C
 HI/RSsNv/e/wVP3Mf4pONjZ5zoCl/S5TYyNug/ogipmO8UtKlbeokmClGbJkTmlkU4wnLs5N
 IvTeMnEMJrpIfQP8dZCfM9EieVD7nlmmwv7HMmnpzz6j+b2TCPLGN8tbQrWBshkvfjsiFiEo
 753aZHWoz0BCrCWSneMq+Y7cwtVRUXX8Lit9qS7gMbYflE5cIzgYteNqY4cl3tNxfoKzLuYp
 SHtMqKaoXKm7UD6xcyxQigLQNvSsVxX9BrX5AQgYgSl3WYNe4Gq4PtNfpc7Z+d16+Fpi/J5F
 qFXd8KFC/VJazLG5zVEMcij9tM/LkzziFLcJTehbRg+Y4VkGV7D9OjkSQ2zpiMAOSy66Jklq
 Lq62wKHGpcOHlwwDMvfZP+14Um2uHwRxLB7U0fSfItMdU+q/IUzc379ifo+IsctLxTfx2LGh
 ljMXkpC/bHA+tZn/sPIiKaIq5aSP9F/RkcKTXPG6buWNDXB+jTxy4F3UNGOIWLXWlTy9fjwf
 u5S1fz9bKYKkVsW4YpxF7FnkfA369f1/uYIywN5ADPUYl7tBr45eiuK2sxGt6tswL5FuFLqC
 xzVpYQAYe2EaJH/DVocBAs5deDdh/sarTnl66hnKkvN4iIqrqGMVl9fPkXXhSEBfqF5Npgpn
 bUotMIMslXtjx03LpCZgyoS+2nVdi4MVKAut5c7Bo73i1N3mw8YPsGGUnf7sMOVdtFBEkg2O
 TvK1qDMsLRrwBaQeXQEE3WQj/FWgo4DuUwRwVIPT7hTdgEpWhPqMNxtHTULosB9yxJaz6RsN
 2ItO0AdyWBiOdt3rJArYoxuM1gp6N6lFojZ1FYD0mHUJ6VtfnKYN3UzYI5h42hAm1+xvVFnE
 HWw12vvFzrnFC00Mu3eRmY9w8HeoRdNGsEuVSxp8wlp33X3XNY9vpKTWA==
IronPort-HdrOrdr: A9a23:GFiczKs3pmoPhpHnVseMxM4N7skDWNV00zEX/kB9WHVpmwKj5q
 eTdYcgpH3JYVcqNE3I/OrqBEDuex3hHPJOkO8s1PKZLXDbUQiTTb2Kj7GM/9SIIUSXm9K1l5
 0QF5SWY+eAbmSS4/yKhTVQX+xB/DGdmprY/ds2Ik0dNj2DUstbnn1E4o33KCdLeDU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,218,1647298800"; 
   d="scan'208,217";a="35831301"
X-MGA-submission: =?us-ascii?q?MDH/aQsTRDz04n0v3VvgrvwSBhOYLxutl0ibhi?=
 =?us-ascii?q?mwVsXggYX56/Ac3nRuj/KPXN+DVnq2TtOKwjMVCbApnzF7kpx+qaxsGb?=
 =?us-ascii?q?9kM1JOIz9CFfBTI2f/UPBK62jLW+4IgHo7ZIxWDGzLyD4IOE4Y4nr1Gn?=
 =?us-ascii?q?XMqsVWXTE/o9xQNRCYXGU81A=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 21:54:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1652298863;
	bh=9iFscmqHHS5c+8/1I68MknfRpKdZBVNdOKN/N9ESwqw=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=U5qwkEhGgHoGwMzvok5kPJdYePgfxE9mQ5kzcgnqG4iPPkkdt1zO4mHAebOELtqfa
	 yQiCfZkR2TI8jgaK3h0479Q/z362r3P4XVVC8ljpMth/vrs7CWz3EOvOaouTJQVJNO
	 Q0JACWyAu6Q5ZSP2JVRCCz8YeroI6rwDguQsZqdo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.6.210]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLRUX-1nYAsH3O43-00Iado; Wed, 11
 May 2022 21:54:22 +0200
Content-Type: multipart/alternative;
 boundary="------------009udAa1xYIXxTMZxy0HvEQN"
Message-ID: <6db18228-f313-d535-8756-4a2c67905c52@web.de>
Date: Wed, 11 May 2022 21:54:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-GB
To: Alessandro Carminati <alessandro.carminati@gmail.com>
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2205091216530.2394@hadrien>
 <CAPp5cGRMAOanfvuhV1LAV9eZka8ZJHRPy6ncMwO=Q+C=GUA2gA@mail.gmail.com>
 <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com>
 <6a926cad-e15a-5c04-1fc9-34d20bd18618@web.de>
 <CAPp5cGQRKxk5RXn7a=7R3s4y=fsvi_O9aFUj6HudPSX+06-_2w@mail.gmail.com>
 <alpine.DEB.2.22.394.2205100957160.2667@hadrien>
 <CAPp5cGS+4snNh+8S3vFw01MMbUjYgpL2qm0tUPrZ1FUtK8bz9Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101123120.2667@hadrien>
 <CAPp5cGQMuy3aM5cLYk4HH8Ny=uH_t2yhWasfmT2AS7M12YDiWA@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101236050.2667@hadrien>
 <CAPp5cGQzYtDVjE-K_Vpt3cbqYW-cwNTLmt_KwdpMdds9L7rXug@mail.gmail.com>
 <alpine.DEB.2.22.394.2205111011380.2811@hadrien>
 <CAPp5cGSVQ5YjQjfvjt3UwHmnRyJsrDEvt92bQoGyNewkAkNLEA@mail.gmail.com>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAPp5cGSVQ5YjQjfvjt3UwHmnRyJsrDEvt92bQoGyNewkAkNLEA@mail.gmail.com>
X-Provags-ID: V03:K1:o2DmpCl3RZxOaOW2loTN5cASODZVxU9Kg/wk6eM1LCmzSM/MLhN
 tcOhc7TRtQPIliMvs0YOqQjMMop5dM1qJ64LI/ARCQr6l4yuzmNsUlEVhHopm91A4HIG2OE
 247RFj4oLWVmgXZHFiHAYxW3xr8v04syvjzTXwQBA0ixTfsLlH+BnwYnXv7SgRpRCUHU9QE
 +grU0gpjRz/dYbE+zc+0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DZmfnpeovZc=:YsvJc5ULwL0X1MouVkSX2S
 q8r6PiP0jPuSO5YD7JecTbMKnTlIAF+7QPvF/sTtv9jZtvB0oi9FJ4XbC90XEhcscVMSw4M9h
 j8O6geztchB+1m3kBDekNaWzlovA3g9nTOGOj5DFzVkByeCg6L+UdcWx5nliT4em9ulRXJ/ci
 j5HwxRYVzDJP7aLc3sl14MWtMX7qVv0V9uJH1NxZTHvH3mU5OxIcsSz+yVFDbjYLzd8cm1El4
 nQMOKtqRHHN5BD+ZImrztMwZ2/RoHwiive3qNwaaE+v4lT5NIS+TZuTkX1fpA6lEqpB+kVX4W
 cIJZFo/vYq1LJODJ5F0GDwVHw4L6n5TWECuXifpWLCQ7ga6nlzxhliOZm5Aj2UA7grHeEcWbK
 gkESD7eChmYOu5jThMza3cloo3wCi7E2pYA8MxMp91GkkmEZ3xYkPUUS+2O7eN148+OX+Mi9V
 zxt9hQUDH8VxqBTMG4/TduyRHarcpP0kPXLWnnWv+axzI4uwTG5mnaZ5AWU1g40pjSF2tuTF9
 Gxj8sgtKZEfQjXOp5YG50ei0al01unYwQV7ju4KbGSzwqWg8StydlEodzrR/J1UvR5hnFFNWi
 XIk4aDKashs9GA2IgfqQkl1kDZ8oOf5vPK9TUSsBR8a/YZkCUFIc5CmQKj6gW3iSS+JyYESOa
 Xmcsed/tbfff4Ya6gfi1Y54l/46F6+W0Uzr2omxhlWMMDCYbpMBm+NxuSJJKQqOubTe+hn2zG
 1SVBw5wLkZW/mUskixMXevIK/ZWOQCwu+d0g9oImguWT1J/0MjKXJ12/0yhLSbsecb0GgHsHe
 7QmYlYW7QNyf3JRBU6bJ9FvhDFP3PN3kf4son/wTJicQ2Q8p0MbyxQ4lbx1QW9GmB7HY9U6mE
 3wnq0tfPFd0oClDkRoTUolsG0Qe03Bne1LQGstmuhf1ObNbWD95hDbi7OSfupJ/oxyzGO0Qty
 mqEKCZJlq61QvfaAjCxFbCgz8blaONr/UdJMkG9sZk9Ervtw3xP+ynSOfCSQudHm0+CkvNb3D
 deyV24SEV2QG/F0zrRgVkqv5Y6X1EEX7fLallzi2cZj/6dpHPxK89GdO2Lv+P8p9Byu45LzNP
 iu27khuEPJyQD4=
Subject: Re: [cocci] List global variables with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 385
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/6db18228-f313-d535-8756-4a2c67905c52%40web.de>

This is a multi-part message in MIME format.
--------------009udAa1xYIXxTMZxy0HvEQN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> I was convinced that what I called the "script" included inline in the m=
ail I sent was the semantic patch.


Such interpretation of the discussed SmPL code can be reasonable to some d=
egree.

The term =E2=80=9Cpatch=E2=80=9D would usually be connected with some chan=
ges.
But you described so far that you would like to perform analyses for selec=
ted source code.
Thus modification specifications were omitted.

How do you think about to use the wording =E2=80=9Csemantic match=E2=80=9D=
 in this case?

Regards,
Markus

--------------009udAa1xYIXxTMZxy0HvEQN
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-=
8">
  </head>
  <body>
    <blockquote type=3D"cite"
cite=3D"mid:CAPp5cGSVQ5YjQjfvjt3UwHmnRyJsrDEvt92bQoGyNewkAkNLEA@mail.gmail=
.com">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">I was convinced that what I called the
          "script" included inline in the mail I sent was the semantic
          patch.</div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Such interpretation of the discussed SmPL code can be reasonable
      to some degree.</p>
    <p>The term =E2=80=9Cpatch=E2=80=9D would usually be connected with so=
me changes.<br>
      But you described so far that you would like to perform analyses
      for selected source code.<br>
      Thus modification specifications were omitted.</p>
    <p>How do you think about to use the wording =E2=80=9Csemantic match=
=E2=80=9D in
      this case?<br>
      <br>
      Regards,<br>
      Markus<br>
    </p>
  </body>
</html>

--------------009udAa1xYIXxTMZxy0HvEQN--
