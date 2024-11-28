Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07866E7716F
	for <cocci@archiver.kernel.org>; Wed,  4 Dec 2024 22:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ZACMslqIaF7iVtmlx12c8LPoSlN7TzLegXngDuX2z78=;
  b=figvmCMcVfUEtU+lem3Xec5amelzcmFNR5aDpHdQ63RLOJgKY1xSK3/b
   uWTT686KkK26vYa5n4NGiRpA5Hq0eXscu9oLbYwrr4RD7jQ1Au3Kva35q
   BZfvLaovWtwtRQDfSxh+gLsopNwNvC2YGbWexmW5HT/4d5RgvXhnS29RH
   E=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@redhat.com
X-IronPort-AV: E=Sophos;i="6.12,208,1728943200"; 
   d="scan'208";a="197421283"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2024 23:28:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 165D8E0D20; Wed,  4 Dec 2024 23:28:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D4638E00B6
	for <cocci@sympa.inria.fr>; Thu, 28 Nov 2024 13:28:56 +0100 (CET)
IronPort-SDR: 67486208_f1zCC5OhRLBQ4rutJRKyS0ESldxmjAPp0FU9xH/3OTgZh7S
 x2cxFJXfzXjBtVnLePUACIWQzK+tbF9L/MzymPw==
X-IPAS-Result: =?us-ascii?q?A0EoAADbYEhnfnyFCqpaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YJDggoEC0iEVogdhzCCJJ4XgX4PAQMBCwEBRAQBAQMEhQACimMCHgcBBDAJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4SKYV7DYJiA?=
 =?us-ascii?q?YEkgSYBAQEBAQEBAQEBAQEBAQEBAQEXAg1+AQEBAxIRBBkBATcBDwsLAwoCA?=
 =?us-ascii?q?iYCAiESAQUBHAYTIoVEA6QlAW6BBUKKQwEBAXh/M4EBggwBAQbcH4FkCRSBB?=
 =?us-ascii?q?i4BiEsBgWyDfYN9eicbgUlEgUqBBoFvPoFSgjgcHRWDRoJpgkSFDyWFNoNKm?=
 =?us-ascii?q?3ImCR0DBwcODR5JDwUcA1khEQFVExcLBwWBKSEsAQIBgkZ/gTaBUQGDEEqDL?=
 =?us-ascii?q?oFeBTcKPYJKaUs3Ag0CNoIkfYJNhRmBC4EVgklMGS8DAwMDgzyGMEQdQAMLY?=
 =?us-ascii?q?gs9NxQbTKFJRoNMgQ4cmRUBr3mEJKFeM6pRLodkkGmpAAIKBwYRI4FEOoFcM?=
 =?us-ascii?q?xoIGxVsBoIwTwMZD44hg3rIbEE1PAIHAQoBAQMJkGsBJwyBSwEB?=
IronPort-PHdr: A9a23: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
 d0uf0qdSwYky77DTnw0
IronPort-Data: A9a23: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
 RH0i0UD6I+5xIy9FVFYJcjlO368b57UMwz0sQ==
IronPort-HdrOrdr: A9a23:eiO00K7WI55S+CxTogPXwHXXdLJyesId70hD6qm+c20rTiX+rb
 HdoB17726GtN91YhodcL+7SdK9qB/nhOZICMwqTM6ftWrdyQyVxeNZnPHfKlTbckWVmdK1l5
 0QFZSWY+eAcGSS4/yKnDWQIpIOxsKY+Lukieqb43BmVhFydq1shj0ZNi+rVmNzACdJbKBJd6
 Z0JfAmm9NjQxoqhwiAdxw4t0WpnbD2vaOjRR4DCxQu8hTLqRyDrJbVPVy5834lPw9n8PMH8W
 zImQTi++GGnNv+8yT7/Svywv1t6arcIlwpPr39tiDAQQ+c9DpArb4ROczngAwI
X-Talos-CUID: 9a23:HxaQGWBNB0AAb5n6Eyda0lBLF+cmTlme4krsGxa2J013arLAHA==
X-Talos-MUID: 9a23:SQ8TYQkw0/lWksyHPp8JdnolCv5i06CEVXoznJFZmfLYOiJ6YSaC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,192,1728943200"; 
   d="scan'208";a="196288582"
X-MGA-submission: =?us-ascii?q?MDFfGIwi3QRh/gIHFEmtsjGKsu5g5FR/REUU4X?=
 =?us-ascii?q?3LpGluPPZHgWqjzsKe0T0H4saiuEe6cT4EbfFJFOUCWfEwEGS0x4un6o?=
 =?us-ascii?q?+rQsCV0mQkOX+JKsxUkSXVIp3EvsJpC+fzTqD/RwazEwZf/UUfwSvXYg?=
 =?us-ascii?q?EVQOn8h1HNNCiH+qKvZg7auA=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 13:28:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732796934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZACMslqIaF7iVtmlx12c8LPoSlN7TzLegXngDuX2z78=;
	b=SR+2143n/ny/c1ljGZjDnEADm/Ip4JnzZKHEGegX2fSpQuWWcE1/kNzNUvhvIvpffUaami
	pQnV8KfkLGfnmwFF1tW7gB4vxoTu6M1GGF94HZMZeKWCvFMHdHksmJydcDHl7j7pLyw10t
	usmZaRSuxFMIGWqNTbACv75cFVGLQL0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-1sCGjwlhMbm5v22xFDgS8g-1; Thu, 28 Nov 2024 07:28:53 -0500
X-MC-Unique: 1sCGjwlhMbm5v22xFDgS8g-1
X-Mimecast-MFC-AGG-ID: 1sCGjwlhMbm5v22xFDgS8g
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385d7611ad3so48555f8f.2
        for <cocci@inria.fr>; Thu, 28 Nov 2024 04:28:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732796932; x=1733401732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZACMslqIaF7iVtmlx12c8LPoSlN7TzLegXngDuX2z78=;
        b=h/Dak6G87KANxUbc3cuzNeO3J6IuM4Wma0GOzrxLmZJB+HAQMSFtFagrgvoOw7hUbE
         kfvh9ChEHvrQdqyuD3zOFxLJMEh17jFEc620ApqOECEa7vn5P9CbyAx8MpgfFjnod8ZK
         CYlIReJfWtgUqGGndqHhVo/R6MLC94tD0oWoyn3pGY49VgAAKp5whgfDHTXcSXvqpbMP
         /6s44HBorvyKHljDUgcbYXPWX0l4+Ujsvu3CM2/lDyeOcRhL2F8jwgBg+MGvYzElEHfY
         PT3AV3fE02v2xvmaZQiGm9Hqk8t/WGDB2pKiqfKxFjW8sEJ1rTjpAmz57jBdCxAenyGj
         wgkQ==
X-Forwarded-Encrypted: i=1; AJvYcCULWMbafe17MCpEREFlFl+dGOGW5bumW9BbNkjNjQmn8M8Ym00rtffATgAWDplpzBgizjpL2A==@inria.fr
X-Gm-Message-State: AOJu0YwCZodKi8ufw4zYX2sL2/BXXhStwz7L5Ep+v1MyPdmN7cJGIQr0
	Fjuofr0ONquWr5mw++HJ13Xe6+lJjI/aEfVjKq5TVsz5ebQWApSJaybKBu/0qVcT4slG/0y+1QO
	LK4LPdlu1C+Vch8TGZZK5pG3255OP8m0tKpl+KBhA5a36CezTP8ktFM0ytuukwMceVFLholGxw7
	3pW/WdWoXfeH2/sMfpvw==
X-Gm-Gg: ASbGnctn3D0iDB8qeN9XKqyV6z/nUiNkhQMYv9luNwYP/RDru+H7lfE0QOeRBuohQqW
	hnFsVLKm1M1Rd9D3vKhRqyA5JqK42xCo=
X-Received: by 2002:a05:6000:18ac:b0:382:4a27:1319 with SMTP id ffacd0b85a97d-385c6eb5840mr5776150f8f.6.1732796932000;
        Thu, 28 Nov 2024 04:28:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGOqoP8tsZ6KQpRsoqtGa6KHF61EJ3NUmj3Aw3MlprtODTvHQ/TDY7uTpa3Nw0Vy2Is2RlK3QrcXMwzmVV8rU=
X-Received: by 2002:a05:6000:18ac:b0:382:4a27:1319 with SMTP id
 ffacd0b85a97d-385c6eb5840mr5776067f8f.6.1732796931576; Thu, 28 Nov 2024
 04:28:51 -0800 (PST)
MIME-Version: 1.0
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
 <20241115-converge-secs-to-jiffies-v2-18-911fb7595e79@linux.microsoft.com>
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-18-911fb7595e79@linux.microsoft.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 28 Nov 2024 14:28:40 +0200
Message-ID: <CAO8a2SgQ-==SjhDFZpi2s3r9FUGA96jwuJL7kTDwE=Hw4UcgUg@mail.gmail.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>, 
	Oded Gabbay <ogabbay@kernel.org>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	James Smart <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
	Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Xiubo Li <xiubli@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	Christian Gmeiner <christian.gmeiner@gmail.com>, Louis Peens <louis.peens@corigine.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cocci@inria.fr, linux-arm-kernel@lists.infradead.org, 
	linux-s390@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, linux-scsi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-block@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	linux-mm@kvack.org, linux-bluetooth@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-rpi-kernel@lists.infradead.org, 
	ceph-devel@vger.kernel.org, live-patching@vger.kernel.org, 
	linux-sound@vger.kernel.org, etnaviv@lists.freedesktop.org, 
	oss-drivers@corigine.com, linuxppc-dev@lists.ozlabs.org, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -BgUuIQbuC3IRF6Y2hIXUnU2VaoeGGsQTqUCPF_52DM_1732796932
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 18/21] ceph: Convert timeouts to
 secs_to_jiffies()
Reply-To: Alex Markuze <amarkuze@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 2149
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/CAO8a2SgQ-%3D%3DSjhDFZpi2s3r9FUGA96jwuJL7kTDwE%3DHw4UcgUg%40mail.gmail.com>

looks good

On Sat, Nov 16, 2024 at 12:32=E2=80=AFAM Easwar Hariharan
<eahariha@linux.microsoft.com> wrote:
>
> Changes made with the following Coccinelle rules:
>
> @@ constant C; @@
>
> - msecs_to_jiffies(C * 1000)
> + secs_to_jiffies(C)
>
> @@ constant C; @@
>
> - msecs_to_jiffies(C * MSEC_PER_SEC)
> + secs_to_jiffies(C)
>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  fs/ceph/quota.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index 06ee397e0c3a6172592e62dba95cd267cfff0db1..d90eda19bcc4618f98bfed833=
c10a6071cf2e2ac 100644
> --- a/fs/ceph/quota.c
> +++ b/fs/ceph/quota.c
> @@ -166,7 +166,7 @@ static struct inode *lookup_quotarealm_inode(struct c=
eph_mds_client *mdsc,
>         if (IS_ERR(in)) {
>                 doutc(cl, "Can't lookup inode %llx (err: %ld)\n", realm->=
ino,
>                       PTR_ERR(in));
> -               qri->timeout =3D jiffies + msecs_to_jiffies(60 * 1000); /=
* XXX */
> +               qri->timeout =3D jiffies + secs_to_jiffies(60); /* XXX */
>         } else {
>                 qri->timeout =3D 0;
>                 qri->inode =3D in;
>
> --
> 2.34.1
>
>

