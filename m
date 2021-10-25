Return-Path: <SRS0=o+tk=PN=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B8AC433EF
	for <cocci@archiver.kernel.org>; Mon, 25 Oct 2021 15:51:35 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE1260720
	for <cocci@archiver.kernel.org>; Mon, 25 Oct 2021 15:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7FE1260720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AxuvqVKK0rgYLs8KyFE+RwJQlxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHDv02wm1TYPymMWWmjXbP+Oa2r3cohyPo7jp09U7Z6EmoNqS1BcGVNFHysb8?=
 =?us-ascii?q?5KdbTi6Bh6tZH3KdpWroHqKXqzyU/GYRCwPZiKa9kjF3oTJ9yEmjPjQHOekUoY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWHULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIsi?=
 =?us-ascii?q?0l67yNEwMWL/bewaU4pZUc/H40l4T/WprjPx9baREAatUo2zhc9RZw9JGvp31T?=
 =?us-ascii?q?hgvM7fkmeIHUhAeHTsW0ahuo++Zeijg2SCU5wicG5f2+N1lC0o9PKUR4O13AH9?=
 =?us-ascii?q?D77obJSoLYxTFgPi5qJqxS/J3l8otBMbuNYIb/HpnyFnxBvErR53Fa6rP7N5cm?=
 =?us-ascii?q?jw3g6hmEf/YIchfdjtraBXJZgZnNVIeCZZ4l+Ct7lHzeiNZpEmSo6Y57Gz7wwl?=
 =?us-ascii?q?40byrO93QEvSGSINOmVuKryTN+H70BA0bMvSQzDOE9jSngeqntSjgRYYWBZW38?=
 =?us-ascii?q?fllhFDVzWsWYDUcWF22rfi6lma+VtNZJgoO/SEttsAa/0isScLVXR2zpHmDpVg?=
 =?us-ascii?q?XXN84O+Ez7gCAzuzQ7hSSD24DZjpAbtU8s4kxXzNC/lSJhdLyGTt3sPufTn+d8?=
 =?us-ascii?q?6idqT+/IwARLGkIZDNCRgwAi+QPCqlbYgnnVsxkHOuxj8bpFCrtmmDMrS4khrx?=
 =?us-ascii?q?Vg9Rj6klyxnif6xrEm3QDZldvjukPYl+Y0w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,181,1631570400"; 
   d="scan'208";a="386387"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Oct 2021 17:51:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EBBA4E0018; Mon, 25 Oct 2021 17:51:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D07D9E0018
	for <cocci@sympa.inria.fr>; Mon, 25 Oct 2021 17:51:30 +0200 (CEST)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=gregkh@linuxfoundation.org; spf=Pass smtp.mailfrom=gregkh@linuxfoundation.org; spf=None smtp.helo=postmaster@mail.kernel.org
IronPort-PHdr: =?us-ascii?q?A9a23=3AqQbTIRa0L9NqFytDVh/jIRP/LTH30IqcDmcuAno?=
 =?us-ascii?q?PtbtCf+yZ8oj4OwSHvLMx1gePDNyQtq0MotGVmpioYXYH75eFvSJKW713fDhBt?=
 =?us-ascii?q?/8rmRc9CtWOE0zxIa2iRSU7GMNfSA0tpCnjYgBaF8nkelLdvGC54yIMFRXjLwp?=
 =?us-ascii?q?1Ifn+FpLPg8it2O2+5YHfbx9MiTagbr9/LBe7phjNu8cLhodvNrw/wQbTrHtSf?=
 =?us-ascii?q?ORWy2JoJVaNkBv5+8y94p1t/TlOtvw478JPXrn0cKo+TbxDETQpKHs169HxtRn?=
 =?us-ascii?q?CVgSA+H0RWXgLnxVSAgjF6Bb6Xortsib/q+Fw1jWWMdHwQLspQjmp8btlRwH0h?=
 =?us-ascii?q?ycGLz458X/YispsjKJAvRmtowVzz5PIbI2JMfZzeL7Wc9EHSmpbRstfWSxPDJ2?=
 =?us-ascii?q?hYYUMAeoOMvpXoJT/qFYVsRuyGROhCP/zxjNUmHP727Ax3eQ7EQHB2QwtB9MAs?=
 =?us-ascii?q?G7Ko9X6KawcVPq1zK7SwjXDdv9Y2y3y6JLUchAku/6MW697fM3eyUk1CQzFgVa?=
 =?us-ascii?q?QqYz+MjOR1+QNtXWb7uVuVeKolm4nrRx+rSKzxsctjYnJgJgZylfe9SV22Ys4I?=
 =?us-ascii?q?8CzR0Fnb9C+CpRQqz2aOJVsQsMkW2xluCY3x6EatJKnfCYH1YoqygPRZfGDboW?=
 =?us-ascii?q?F4w7vWfiPLDl3mn9oerCyihS8/0Wgy+DwSMm53lhKoydFnNfBtnAA2hrO4caEU?=
 =?us-ascii?q?vtw5lqt1DKM2gzJ9+1JLkA5mbDFJ5Ml2LI9kp4evELeFSHsgkr2lrWZdkA89+i?=
 =?us-ascii?q?o9evnZrLmq4eZN4BuiwH+Nr4ims+hDuQiNAgBQWyb9f671L358k31WLRKjvson?=
 =?us-ascii?q?anFqJ3WOMAWq62jDwNI3Ysu6wyzAymi3dgCmXQKKEpJeBedgIjoP1HOLur4DfC?=
 =?us-ascii?q?6g1m0nzdr3e7JPrLiApXNNXXDlLbhfbBg609Txgozys1f55RJBb4bPPLzW0jxt?=
 =?us-ascii?q?NrCAh8+KQy0zP7rCM9h2YMGRWKPHqiZPbvOvl+P+u0gP+iMaZQOuDf9Lvgl/+T?=
 =?us-ascii?q?hgWU4mV8bZ6mp3IEYZGq2HvR8cA2lZi/OhdpJKWoQtQozV6S+ilqPeSZefX2yU?=
 =?us-ascii?q?rl67TY+XtGIF4DGE6+3jbPJ/z28F50TRmlcFlWFFz+8eJ+JVPQMQCaTJNJxnDs?=
 =?us-ascii?q?ZU7SoV44m01eprgCsmOkvFfbd5iBN7cGr79Ny/eCG0EhqrVSc7uyY2mCJCWJ5h?=
 =?us-ascii?q?GUFQ3kxxq8t+SSVJX+H0K5lk/JfCNpf7u9IVQF8MoTTnbUS4zXaXgPHY8eHT0u?=
 =?us-ascii?q?gTty6ADY3CNUrzI1WC3s=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A+j19lqCS6vBodzPlHemu55DYdb4zR+YMi2TD?=
 =?us-ascii?q?pHoBMCC9E/bo8fxG885rtyMc5AxxZJhko6HmBEDiewK5yXcW2/hzAV7KZmCP0w?=
 =?us-ascii?q?HEEGgh1+TfKlbbdxEWmNQy6U4tSdkaNDWsYGIbsfrH?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AEAAASaxphmGMdkcZaHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQFAgUUHAQELAYN3OzGMa4clggcgm2iBfAsBAwENQQQBAYRhAoJrAh0?=
 =?us-ascii?q?HAQQwCQ4BAgQVAQEFAQEBAgEDAwQBEwEBAQEBAQEBCQsQBjokhWgNgjUpAYNkA?=
 =?us-ascii?q?QIDOgYBATcBDwsYHBIQRwaDBIMIp3mBM4EBggcBAQaIAgmBOgGMeHonHIINhDo?=
 =?us-ascii?q?+ij+FJgGVEatDgzKeUiumdbZdhHmBYIIUMxoIKAiDJFAZDo4gGYhthUxCLzgCB?=
 =?us-ascii?q?gsBAQMJiXUBAQ?=
X-IPAS-Result: =?us-ascii?q?A0AEAAASaxphmGMdkcZaHAEBAQEBAQcBARIBAQQEAQFAgUU?=
 =?us-ascii?q?HAQELAYN3OzGMa4clggcgm2iBfAsBAwENQQQBAYRhAoJrAh0HAQQwCQ4BAgQVA?=
 =?us-ascii?q?QEFAQEBAgEDAwQBEwEBAQEBAQEBCQsQBjokhWgNgjUpAYNkAQIDOgYBATcBDws?=
 =?us-ascii?q?YHBIQRwaDBIMIp3mBM4EBggcBAQaIAgmBOgGMeHonHIINhDo+ij+FJgGVEatDg?=
 =?us-ascii?q?zKeUiumdbZdhHmBYIIUMxoIKAiDJFAZDo4gGYhthUxCLzgCBgsBAQMJiXUBAQ?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397315161"
X-MGA-submission: =?us-ascii?q?MDGBs/BFzr6seO4QIwYQA0liARwdfoQ64HHqsT?=
 =?us-ascii?q?/dc1b7qL84joVdpQxINoyefa4Y3oATOga8TcKZrl6V8jGMpjLzR7uYu9?=
 =?us-ascii?q?9qrRdkamh1DaVWL5R9BhXRUdvgIczBgWCW+dIh6P0mbf4ktMH/5TxqLX?=
 =?us-ascii?q?oN77qWZdw1M0edr5adRV2Khg=3D=3D?=
Received: from mail.kernel.org ([198.145.29.99])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 17:51:29 +0200
Received: by mail.kernel.org (Postfix) with ESMTPSA id 528E260184;
	Mon, 25 Oct 2021 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1635177087;
	bh=HxdPjBPnGIttkaa3TypuRSPZtcG6/Elr6j35miiBv0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p/rfnLtAj+aDZSBD1rToQvk7RUgp+D3YaJn3fhiBkTlqO5gGOO2z0EhV4ADY30z6C
	 pRx6Pb4ovHkC2xRtg5bT6+rAABaKfDE6rxwXe2jEnMG9QBUyEjopT1s6E4J3i7xpWj
	 BLcIsJa+IhraWkjOrX8OcFwCanpkiY/Uql9DeZbQ=
Date: Mon, 25 Oct 2021 17:51:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joe Perches <joe@perches.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
	Johan Hovold <johan@kernel.org>, cocci@inria.fr,
	Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
	linux-staging@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-ID: <YXbSfYIuyj3PI6pm@kroah.com>
References: <20211025120910.6339-1-johan@kernel.org>
 <20211025120910.6339-2-johan@kernel.org>
 <fdb677be-6e06-fef9-811d-bb2c71246197@lwfinger.net>
 <094a8f50ccef81e0317c89d0a605c327c825d5cb.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <094a8f50ccef81e0317c89d0a605c327c825d5cb.camel@perches.com>
Subject: Re: [cocci] [PATCH 1/2] staging: rtl8192u: fix control-message
 timeouts
Reply-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Loop: cocci@inria.fr
X-Sequence: 33
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/YXbSfYIuyj3PI6pm%40kroah.com>

On Mon, Oct 25, 2021 at 08:41:36AM -0700, Joe Perches wrote:
> On Mon, 2021-10-25 at 10:06 -0500, Larry Finger wrote:
> > On 10/25/21 07:09, Johan Hovold wrote:
> > > USB control-message timeouts are specified in milliseconds and should
> > > specifically not vary with CONFIG_HZ.
> 
> There appears to be more than a few of these in the kernel.
> 
> $ cat usb_hz.cocci
> @@
> expression e;
> @@
> * usb_control_msg(..., HZ * e)
> 
> @@
> expression e;
> @@
> * usb_control_msg(..., HZ / e)
> 
> @@
> @@
> * usb_control_msg(..., HZ)
> 
> $ spatch --very-quiet -U 0 -sp-file usb_hz.cocci .
> warning: line 4: should HZ be a metavariable?
> warning: line 9: should HZ be a metavariable?
> warning: line 13: should HZ be a metavariable?
> 50 files match

Look at the lists, he's sent a bunch of fixes for this today to all the
subsystems...

greg k-h
