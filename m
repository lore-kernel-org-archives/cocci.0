Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663D1C433EF
	for <cocci@archiver.kernel.org>; Fri, 22 Jul 2022 19:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/fAj1KHVDl162VxFU9TLfLlQz04DRqy9g3rcwwYf5v8=;
  b=SW28nRdKC1nS1PBbDLB/PWw/Dmf5voGmOSRyIX0wY65GaDLieDbmBAw9
   xxFW7SGU5av98kOb6YDPeZ15daCyMNRDwQIPyYd9Cbd/uZ3be/92T/Co/
   F0c4X2f17wek30K1gZABK8u5Fhn1Op3q02pS3bJCKjFyQLDGz5FCLqpJ1
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@redhat.com
X-IronPort-AV: E=Sophos;i="5.93,186,1654552800"; 
   d="scan'208";a="46627830"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jul 2022 21:23:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 42023E02D7; Fri, 22 Jul 2022 21:23:43 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 77868E0260
	for <cocci@sympa.inria.fr>; Fri, 22 Jul 2022 21:23:38 +0200 (CEST)
IronPort-SDR: Yp6dk6E8Q6hXW7vsOwgWKcU2LLqKEToqLJhvUTxiUtPnU7Cwh5W53igXR0JfThvfsZS+q6fMUf
 QLDFj1yppz+Pitam5+fYKLlv3Bqqijm0N4j/Ou+YN4HVuMwYo59tm3UjJJnWG1Sm45iCriIhUs
 GaqdatGE6wOCgJo0zzQAtVyzt6Vl2HHz4iDvcG0RZwnRQOHq81KCKXiqTPaXG6GUjCWLpMCNlE
 l5RWpE+Ae5ouE7hYGRjksGDqBH2dfObhiHbWJf48YhEvfArRQC5jkOdzLI0Fy1XCKe0wSiuYU7
 YxhYJpxFIPm7gzy9/M5JqtRn
X-IPAS-Result: =?us-ascii?q?A0DhAgDi+Npih3yFCqpaFnODc4EBgQQEC0UDjUmIDZ0Qg?=
 =?us-ascii?q?WgLAQMBCwEBLA8HBAEBgVKCb4UyAh0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQEARMBAQEBCwsLBQgKBw4QBTxkgQgBgU4BgTAjCwMxDYI1D?=
 =?us-ascii?q?IQEBREoBgEBOHQUSAkQCYJbAYMYAxCdPgGMaQEBAXaBM4EBgggBAQaBPwGBH?=
 =?us-ascii?q?4UJCYE9jhd6JxYGgUlEgRWFO4EPAgOBQwJlg0CCLpxTOAMaLS8SgR9sAQgEB?=
 =?us-ascii?q?gcKBS4GAgwYFAQCExJTFgISBQ8ZDhQbIhcMDwMSAw8BBwIJEAgRJQgCAwgDA?=
 =?us-ascii?q?gMmAgMWCQ4DHQgKGBIQEgIEERoLCAMWPwkCBA4DQggOAxEEAw8YCRIIEAQGA?=
 =?us-ascii?q?zIMJQsDFAwBBgMGBQUBAxsDFAMFJAcDHw8jDQ0EIh0DAwUlAwICGwcCAgMCB?=
 =?us-ascii?q?hUGAgJOOQgECAQrIw8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFgIQCAIIJxcHE?=
 =?us-ascii?q?xgbGQEFWRAJIRwoEAUGEwMgbwUKOw8oMzY8Kx8bCoEVKisWAwQEAwIGGgMDI?=
 =?us-ascii?q?gIQLjEDFQYpExItCSp9CQIDInEDAwQsLgMJIR86nF+CXl8BIjuBYK4AR5MQB?=
 =?us-ascii?q?wODUYsijQOHWQQWMYN2gVCREgw4g0COC5Z8imSCVIcfklQCBAIEBQIWgXiBf?=
 =?us-ascii?q?nAVO4I0AQEBMQlFAQIBAg0BAgIDAQIBAQEJAQEBAY42g1mFFIVLQDQCAQgwA?=
 =?us-ascii?q?gYLAQEDCY8GAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:NSfHwa+FPPOtDy0axN5XDrUDbniTJUtcMsCJ2f8bNWPcYEJGY0x3y
 mUZWG+HbKuJYTbyf9xzb9zg9U4Hu5DUy4dlSFA4pStEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHvymYAL9EngZqTVMEU/Nsjo+3b9i6mJUqYLhWVnV5
 omo+5e31GKNglaYDEpEs8pvlzs05JweiBtA1rDpTa0jUPf2zhH5PbpHTU2DByOQrrp8QoZWc
 93+IISRpQs1yfuC5uSNyd4XemVSKlLb0JPnZnB+A8BOiTAazsA+PzpS2Pc0MS9qZzu1c99Z5
 PZct7G/FSoSYPOLseANazYAAgNbMvgTkFPHCSDXXc270laDaH7w27BiAUU3I4AC66MuWz0I8
 P0dJTsEdQzFjOWzqF65YrAz3oJ6dI+yZ9hZ4ys8pd3aJa5OrZTrWafN49JD9C09isBHAbDVY
 M9xhT9HMEqeOUIfYAl/5JQWwOySnnrDbWdk70uxo/BmvmTtzzxJ6e24WDbSUoHXHJwLwS50v
 Fnu9GPyCRAyL82a0TPD83S2h+aJkzmTZW4JPKCjs+VvnEXWymEXCQMbT0r++KPlzEu/Xt9UI
 lcIvCEpqMDe6XBHUPHRfAy6jXHYkyVCBZ15F/0Cx1mc6I/btlPx6nc/chZNb9kvtckTTDMs1
 0OUk96BOdCJmOLLIZ563ujJxQ5eKRT5PkdZOnBZFVptD83L5dBs3kiWH76PBYbs1oWtcQwc1
 Qxmu8TXuln+pdMQkr6+4UiCjz+op4bEVB9wv1+LGGek6w5ybZW5IYev7DA3DMqszq7GHzFtX
 1BewKByCdzi67nQykRhp81QQdmUCw6tamG0vLKWN8BJG86R03CiZ5tMxzp1OV1kNM0JERewP
 hKD5VkBvsUOYyP2BUOSX25XI5txpUQHPYu/Ps04kvIXCnSMXFPcoXsGibC4gj21+KTTrU3PE
 crGKJ/yUh72+IxizT+7TO4GzfctwToixSvaQJ3hzh+uuYdyl1bKIYrpxGCmN7hjhIvd+Fu92
 48Ga6OilksDOMWjPXG/2dNCdTgicClgbbir+pw/XrDYeGJORjp+Y8I9NJt6JuSJaYwOyryXl
 px8M2cEoGfCaYrvc1vXMCs6Nuy+BP6SbxsTZEQRALph4FB7Ca7H0UvVX8JfkWAP+LMxwPhqY
 eMCfsncUP1DRi6eo2YHYJX9pZAkfxOu3FrcMy2gaTk5XphhWw2WpI61JFe/rHEDXnitqM8zg
 7y8zQeHE5ANcAJvUZTNY/W1wlLt4HUQwbogX0bBLtRJVl/r9Yxmd374gvMtepleMxjPxjKGk
 Q2RBE5A9+XKpoY09vjPhLyF8Nn4QrEiThICEjCCv7isNCTc8m6y+qN6Ub6FLWLHSWf52KS+f
 uEJnfvyB/sKwQRRuI1mHrc3kK8z6oe9p7JeyQg4TnzHY07wUeF9OTyd2NVX86FAwr5HtBGnH
 xvVpp9fOLCEM8r+DBgaIw98NraP0vQdmz/z6/UpIRyiuHIoouTWCRpfb0uWlShQDLppK4d6k
 +osvcgh7Qbg2BcnN9CxiD9ZqjaXJXsaXqR77ZwXXN3xhgwwxg0QaJDQEHStsoyULs5JLlFvL
 jKQhbTPnaUZnxCeNX8yEHXG1PFBw58JvUkSnlMFIl2InPvDh+M2hUUNrGtpEFUNkRgXgfhuP
 mVLNlFuIfrc8jptgv9FVT/+FgxEAiqf5UGsmUACk3fUThXzW2HARIHn1T1hIKzEH6NgkjlnE
 HWw1X2gSjP2ZIT90y8zR0N/urm6F4A38wzHlcuuBNjDFJ4/CdYgbmlCekJQwyYLw+to7KEEm
 QWu1Px9Za3yKWgbpKhT50yyy+ELUB7dTIBdaagJwU7KdF0wvBmo1DSOIlz3ccRITxAPHYlUF
 OQ2Tv9yu9+COOpiY9zV6WPg41O5oRLx2Oc/Rw==
IronPort-HdrOrdr: A9a23:6TrlRKEe0B7qcZ54pLqE38eALOsnbusQ8zAXPiBKOHpom+ij5r
 qTdZUgpGTJYVMqM03I9urvBEDtexLhHP1OkOws1NWZLWvbUQKTRekJgeTfKlbbak7DH4BmtZ
 uIP5IObOEZoDNB4PoTZ2KDYq4dKA3tytHQuQ+zok0dKj1XVw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,186,1654552800"; 
   d="scan'208";a="46627826"
X-MGA-submission: =?us-ascii?q?MDHReHb4Ee8/OJ/sNsR1CEkTC9KZraoC2oOgXI?=
 =?us-ascii?q?P0Pb5GDCFoq+/mTkl4WeaP7U+ozYYMnvDR9JgcyEDeuOpw72u9kM5UjY?=
 =?us-ascii?q?lQhH9A19yZxbdcnxbWRH5Ik817IxhbEW6tdty1s0vhewd7vIEvg5l2aj?=
 =?us-ascii?q?okaFN81ROb80ptzgWCG93eRA=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 21:23:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1658517816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=/fAj1KHVDl162VxFU9TLfLlQz04DRqy9g3rcwwYf5v8=;
	b=NDP/lgkBMkvTW9gxBzSvWvTFqsHAvbt3tIg9VacPeKW41SyVkXTQNGB+5LxxsXr41YtC93
	bS11z5ZQwgrVtsCh/KXaxRrqPftrxdt4bYB2z2zSmJ2YLNwkJdH1PO8johtbdXecfnDL8Z
	eD6pOiiYNDuJ7NHIdWwevOPs5/SaTHE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-xA3sVfevO7yZMPifAZCSXw-1; Fri, 22 Jul 2022 15:23:29 -0400
X-MC-Unique: xA3sVfevO7yZMPifAZCSXw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFDAF811E80
	for <cocci@inria.fr>; Fri, 22 Jul 2022 19:23:28 +0000 (UTC)
Received: from localhost (unknown [10.39.194.225])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 84A6B40CF8F0
	for <cocci@inria.fr>; Fri, 22 Jul 2022 19:23:28 +0000 (UTC)
Date: Fri, 22 Jul 2022 20:23:27 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: cocci@inria.fr
Message-ID: <20220722192327.GA28597@redhat.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [cocci] pcre vs pcre2
Reply-To: "Richard W.M. Jones" <rjones@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 497
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/20220722192327.GA28597%40redhat.com>

PCRE (not PCRE2) is end of life: http://www.pcre.org/

and may be removed from Fedora:

  https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/message/K3BUC6T5VIG7LXOV4RVFO7IUPE2LGA2J/

It seems as if coccinelle has an optional dep on PCRE enabled/disabled
through ./configure --enable-pcre-syntax.  It's not entirely clear to
me what Fedora would lose by disabling this.

Does coccinelle plan to move to PCRE2?

I have moved a few projects over to PCRE2.  It's definitely not an
automatic conversion, although it also wasn't especially difficult.
Here's libguestfs.  This is mostly C and we maintain our own PCRE
bindings for OCaml which are not based on Markus Mottl's bindings, but
it should give you an idea of the changes:

  https://github.com/libguestfs/libguestfs/commit/82493579f38f39769861f31403ccfb8e97b41f96
  https://github.com/libguestfs/libguestfs-common/commit/0b244f2b0cfc920f2432f5df45e108583f0d2901

We decided not to support alternate PCRE or PCRE2 compiles since all
distros have provided PCRE2 for a long time.

Also:

  https://github.com/mmottl/pcre-ocaml/issues/25

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
nbdkit - Flexible, fast NBD server with plugins
https://gitlab.com/nbdkit/nbdkit

