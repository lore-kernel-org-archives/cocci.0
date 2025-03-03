Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2F5C282D9
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gSR1fSju11GwT3CmV4RSTFrBeqMpZeqjsL4Nu+lUL6I=;
  b=uWvAaayNteB5lVB1pkbSCRZnVKnml4HLKfvVo6+kLtlXqEFP87oTrYwt
   Vmc+lyqUE41NaCesu72Mo+xZ++8xkQzINhDZN5Vfl4Hq2HSyiuOJkALkt
   GhA/WGkCff3wnZGXKEe1Z1V8H7mUUuPIGCapE1ZGPTkYNXdTG99CIOOwE
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linaro.org
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211069621"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:59:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 54C75E0F0E; Tue,  4 Mar 2025 10:58:44 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C74DAE0264
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 11:53:54 +0100 (CET)
IronPort-SDR: 67c58a38_trBdkWDhkxpaHebFYEJUoChJyTsCoSvmtclyVM1mLVT2ol2
 1wkXruLezkXKfrv6BjyKtqf1svSUheX0rYGbW3A==
X-IPAS-Result: =?us-ascii?q?A0FVAAAJisVnfC/aVdE9HRwBAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?IE/BwEBCwGCQ4FXMwRThFaIHYVAgXKBdC0DmDiEBoFWgX4PAQMBCwEBQgIEA?=
 =?us-ascii?q?QEDBIIMgnQCixUCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEiGQcOEimFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQINfQEBAQEDE?=
 =?us-ascii?q?hEECwENAQE3AQ8LFAEDAgIfBwICMwEFARwGEyKBYX+CZQECB6IZgQVCikR6f?=
 =?us-ascii?q?zOBAYIMAQEG3CCBZQkJAQqBBi4BhWuCSRoBBW2EYBmEdycPgVVEgRUnC4J4P?=
 =?us-ascii?q?ogegmmCM4FpAYM9mgWFAYlSUnscA1ksAVUTFwsHBWFISAOBDyMPgRQFNAo3O?=
 =?us-ascii?q?oILaUk6Ag0CNYIefIIragQFgSSCN4Q9hECFUoIRgV0DAxYPAYMfdxyEfIRqH?=
 =?us-ascii?q?UACAQttPTcJCxuiMTqDT1IgAVIhLjiBXTYXkm8Ugz2OeqBYNAeEHoFdBgyfX?=
 =?us-ascii?q?gYTL5dFDJMFLphPo1oThRoCCgcGESOBRDqBXE0wgypPAxkPjiE4iFXDV0A1P?=
 =?us-ascii?q?AIHAQoBAQMJhUMmE4oga2ABAQ?=
IronPort-PHdr: A9a23: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
 EJpzAR5Zusp+XHn5FJlfjL3
IronPort-Data: A9a23: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
 k8bi4dAD656F5DTVWYUVwoVvJJJ
IronPort-HdrOrdr: A9a23:hk46AqyhSJz7pT9+wR2BKrPw171zdoMgy1knxilNoNJuA6qlfu
 SV7YgmPHjP+UkssRAb6K290cy7K080mqQFhLX5UY3SODUO/VHYUr2KjrGSuQEIeReOjtK1vJ
 0IG8MOauEYT2IK9voSiDPIcOrIq+P3iZxA692uqEtFfEVEbbp/5xx1BgvePkp9XxleGJY1fa
 Dx2uN34xSlPVoYB/7UOpDHZYf+Th/w+a4OrSRmO/fv0mmzsQ8=
X-Talos-CUID: 9a23:BDlpDG4l/BmPsX+nyNssykcPPps1Wz7nlGbSGFS4NF1HUKzScArF
X-Talos-MUID: 9a23:hsZ4Jwjreag/D6POnyraHsMpbcoy4YODBVE3jYwfoO6+aXxAABi7pWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="210848197"
X-MGA-submission: =?us-ascii?q?MDFs2m8cmHiATpQBjNPCuZX8QOvSOHWfdKEV7r?=
 =?us-ascii?q?ti7uG3tWq09OGo1+dVctaipSCgZ8t/0PJLEwQBjh9KPNKkvq9OKAoCoa?=
 =?us-ascii?q?6CaqFXb0dbRzkf08WbYv0PCxkaoiDUxVpcY+4IXAVpF1VNKFrbbUFuCI?=
 =?us-ascii?q?RBSXPRDoNFsXhIggM6dd1gRQ=3D=3D?=
Received: from mail-ej1-f47.google.com ([209.85.218.47])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 11:53:44 +0100
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abf4d756135so315349566b.1
        for <cocci@inria.fr>; Mon, 03 Mar 2025 02:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740999223; x=1741604023; darn=inria.fr;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gSR1fSju11GwT3CmV4RSTFrBeqMpZeqjsL4Nu+lUL6I=;
        b=r164MqSu0po9Nj3l+WZLOA+Vui876bGgRneZSpHM47ylJ/nqi3SgAtli6d0GpSk4Kj
         XyhmZy2FjZjfK9Lss/vqSCay5Qhe9xM5ozIQbs/KuMY/OP3VA+jgMl8zgGmwrb/mp+Hh
         s1QyNquG+C7vG/9wRIyh8m8+5z/gMWRWjb7v9fqv1wNDfwTbkKvScoVVB3xXF5/DT4L/
         pksE2IJTklLi1P+eQFMl6Wmm9yW8ltsl9C7EheJMvlDnn7E7I+NGmOEdOxbuWFbHopAi
         sBn8+7xsJoARQKLf1Pkip0oQmFuWcsB2d+z5ZyrLHUFgD92NnA6RyNNjELKsQ5LHTcyu
         lYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740999223; x=1741604023;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gSR1fSju11GwT3CmV4RSTFrBeqMpZeqjsL4Nu+lUL6I=;
        b=WE7cQgwYDv/HZUc4GOudZZvfwZ7D8lYus8hZKlMDJdfHXqI8XdVogeCNkSzIeoD+id
         BAoAx4DDlDC4rzepVtVmBj5tNLU15yqvDo6j0WwJDAfdEw192R+4WjBNJ32pq8VCL7iT
         nImVisqzgiclR8SlZHrPIez79Xnq0pIkYzm1hhwBz+wdLDp+z9USR03ci63zGC03gMOE
         nLHbmfGPvSIPW0hyfdgMppocV2XWiENSo962F8bHuy88XMMAbV55Kbqsvw1hiRIQyaMO
         8nY9lRYYXuM7PfuKxR3siraftPMxtee+YIoUCgapmhRVHxTz2rq5L8DWoF1I1wXw2KF5
         6J2A==
X-Forwarded-Encrypted: i=1; AJvYcCUZtqt9MJakYpDRy9D2jaBprgwibN+vJ8HZUai7NL/kLgmonhV5xiZlbDb8Rqmv0E8yqr8ETw==@inria.fr
X-Gm-Message-State: AOJu0YypDD+w+dA7EWUvXyyKYha4P8bjLGcUhjmK7ivsJJOR+MyS8wq/
	167McBqNiF4unOGPZm3g411Faxqm8oiz1rCnFjfVIOeAo/3RZn1PkfaqwTyQMbc=
X-Gm-Gg: ASbGncvr4dVuWbxYBiiW+x+atK3/YA0F8lqIjvWZuhjydZ4n2r5ArOt8eu+pTzXvGpA
	E8vTwrY0x4PWm0JEJgJhCALBIuc2nozy8UgtlX0fucz1XdFNb93sS9yW1/vC0RvjxTnIj4B/jSC
	DsmOiaSsoqdIdKI+tzX3V03KKdHDsEYZAKM8PRiGxbmV/HOVoj3vmVGtjeQqWCcMPHNmkUtWRse
	F+zIFtzCCC0ibvImV5PeGZeETfUN03ss5A5VG84vtm/cBDTQy1GlrCGHBRYf9z79I83apW011Wh
	Qt8y1oJGREHUOOnqKDzVVL8MNFo3Bs3bzylLq7fJIFVUqn5uXg==
X-Google-Smtp-Source: AGHT+IF878WM4Ac0lwU3U8jWhqiDwhdQ1OhLRZrdD2ubBpWef4yPS0ciLaeLOsRMTVQEjBD/4tiTTg==
X-Received: by 2002:a17:906:7310:b0:abf:13cb:c411 with SMTP id a640c23a62f3a-abf25fabbaemr1560894766b.18.1740999223509;
        Mon, 03 Mar 2025 02:53:43 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf55e88748sm421511766b.54.2025.03.03.02.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:53:43 -0800 (PST)
Date: Mon, 3 Mar 2025 13:53:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Antonino Daplas <adaplas@pol.net>, Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Yihao Han <hanyihao@vivo.com>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>
Message-ID: <47c37d1a-5740-4f48-ac0f-635d8b6f51b2@stanley.mountain>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <86551e6f-d529-1ff6-6ce6-b9669d10e6cb@web.de>
 <3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de>
 <ugymllbkcsg22ffgyofvkquh5afbvoyv2nna5udmy3xfhv2rjz@jhgghzldzm4u>
 <eebf8c0c-7a6a-405f-aaab-2a8a8c2bd91f@stanley.mountain>
 <hwk2nf62owdo3olxrwt5tu7nwfpjkrr3yawizfpb3xn6ydeekx@xwz7nh5ece2c>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hwk2nf62owdo3olxrwt5tu7nwfpjkrr3yawizfpb3xn6ydeekx@xwz7nh5ece2c>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH RESEND] video: au1100fb: Move a variable
 assignment behind a null pointer check in au1100fb_setmode()
Reply-To: Dan Carpenter <dan.carpenter@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 2511
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/47c37d1a-5740-4f48-ac0f-635d8b6f51b2%40stanley.mountain>

On Mon, Mar 03, 2025 at 11:30:46AM +0100, Uwe Kleine-König wrote:
> On Mon, Mar 03, 2025 at 01:08:29PM +0300, Dan Carpenter wrote:
> > On Mon, Mar 03, 2025 at 10:19:06AM +0100, Uwe Kleine-König wrote:
> > > Hello,
> > > 
> > > On Sun, Mar 02, 2025 at 07:02:12PM +0100, Markus Elfring wrote:
> > > > From: Markus Elfring <elfring@users.sourceforge.net>
> > > > Date: Thu, 13 Apr 2023 21:35:36 +0200
> > > > 
> > > > The address of a data structure member was determined before
> > > > a corresponding null pointer check in the implementation of
> > > > the function “au1100fb_setmode”.
> > > > 
> > > > Thus avoid the risk for undefined behaviour by moving the assignment
> > > > for the variable “info” behind the null pointer check.
> > > > 
> > > > This issue was detected by using the Coccinelle software.
> > > > 
> > > > Fixes: 3b495f2bb749 ("Au1100 FB driver uplift for 2.6.")
> > > > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > > 
> > > Acked-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> > > 
> > > Should also get
> > > 
> > > Cc: stable@vger.kernel.org
> > > 
> > > to ensure this is backported to stable.
> > 
> > It's not a bugfix, it's a cleanup.  That's not a dereference, it's
> > just pointer math.  It shouldn't have a Fixes tag.
> > 
> > Real bugs where we dereference a pointer and then check for NULL don't
> > last long in the kernel.  Most of the stuff Markus is sending is false
> > positives like this.
> 
> I thought a compiler translating the code
> 
> 	struct fb_info *info = &fbdev->info;
> 
> 	if (!fbdev)
> 		return -EINVAL;
> 
> is free (and expected) to just drop the if block.

If you dereference a pointer then it doesn't make sense to have a NULL
check after that because the kernel would already have crashed.

In 2009, we had the famous tun.c bug where there was a dereference
followed by a NULL check and the compiler deleted it as you say.
And then, it turned out that you could remap the NULL pointer to and so
the NULL dereference didn't lead to a crash and the missing NULL meant
the kernel kept running happily.  The remapped memory was full of
function pointers to get root.

We changed min_mmap_addr so that we can't remap the NULL pointer and
we started using the -fno-delete-null-pointer-checks compiler option so
that it wouldn't remove the NULL check even in places where it didn't
make sense.  We also started doing more static analysis.  We've also
tried to randomize where functions are in the memory so it's trickier
to hardcode function pointers.

A couple years later we had another bug where it turned out you could
still remap NULL.  I forget how the details.  No one wrote an exploit
and it wasn't publicized as much.

Anyway, none of that applies here, because this is just pointer math.

regards,
dan carpenter
