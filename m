Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF914C76196
	for <cocci@archiver.kernel.org>; Tue, 28 Mar 2023 07:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OFrwoAECg/IllS1Wp7MqypF+/1aOHcNGitGJmOxkaAU=;
  b=LBx9/Kb7hnR9SE09kbIz0vfamzt8QQumdN9aGpvswz+91Xyg0Fn2e6oX
   ADONCx5mvt2/pN8gyr11SEWkS4H0T5RKBPfat8GKWl7Mks3MjqJkBZsby
   fR5h/tKnE++NzLrgR2peWFmEPIQIgo+fIWDy3coR2/zL20Bh6onq6QQX6
   0=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,296,1673910000"; 
   d="scan'208";a="99439751"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Mar 2023 09:30:42 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8F2F2E0D4D; Tue, 28 Mar 2023 09:30:42 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7EC9BE0D40
	for <cocci@sympa.inria.fr>; Tue, 28 Mar 2023 09:30:40 +0200 (CEST)
IronPort-SDR: 6422979f_1c2VMPK5manR6v5K11BHUQ8cOAR0UnuSvVpbUlTpyIv3NQ9
 eF9jXZA3hkUsjg1tNiAjl+ogtujmsVzU7K5WL8g==
X-IPAS-Result: =?us-ascii?q?A0HIAABCliJkhk7ASNlaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YItdVYvBAtGhFORAS4DhC+HLIc6hGeEAoFqgSw+DwEDAQ1BAQIEAQEDBIR+A?=
 =?us-ascii?q?oU5Ah0HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABA?=
 =?us-ascii?q?QEYCRkHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESA?=
 =?us-ascii?q?kdTPQECAgEjHQEBESYBBAsLGgIRFQICVwYBDAgBAYJ6AYInAQMOIwevQYEyg?=
 =?us-ascii?q?QGCCAEBBpwKHywiU4FeAwaBFC0BjQQJgy16Jw+BVUSBPAyCdz6DfUc/gxmCZ?=
 =?us-ascii?q?44dgmIBiEIKgTR2gSAOgT2BBAIJAhFrgRIIa4FtD0ACDWQLDnGBSgJkTIEUJ?=
 =?us-ascii?q?QQOAxkrHUACAQs7Oj81BgMLIAZYawIJIxETBQMLFSpHBAg5Bhs0EQIIDxIPB?=
 =?us-ascii?q?iZEDkI3NBMGXAEpCw4RA1CBRwQvXnwKBgEmJJxfbHw/RoFmC5J8sD00B4Iog?=
 =?us-ascii?q?VWBWQyfDAYTLoN9kwsOBjGRci6HLZAPIKJAhTqBeSSBXDMaJIM2TwMZD44gG?=
 =?us-ascii?q?YQMjwkBPj80OwIHAQoBAQMJhUYBAYV7AQE?=
IronPort-PHdr: A9a23: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
 F7a89OsUHcBXbwmr6Aznn4=
IronPort-Data: A9a23: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
 w0hoIfv5esRkNiEndjBDAzfYzqi
IronPort-HdrOrdr: A9a23:iIR3bq1w91KAbaBbLOmHagqjBGYkLtp133Aq2lEZdPWaSL38qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyVMbEQt6bHCWeDYrQd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,296,1673910000"; 
   d="scan'208";a="51443922"
X-MGA-submission: =?us-ascii?q?MDEND0G62f0+C4IvLvi5vENQ20cDcC9L4gwAYp?=
 =?us-ascii?q?fpG315to7JaknjAH7QtteI+F0PuWMRkY8BaewgMpkHtUlnIa1cXVYj7c?=
 =?us-ascii?q?9BlbkQrx+7byG5LclfYj+RchxUA2ZypaOdPIbUO5r8HI15phP8+dFfVC?=
 =?us-ascii?q?EijRmjFgHoK4Rdn6GumQpPmg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 09:30:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679988620; i=markus.elfring@web.de;
	bh=rFTPDXc/9vqgqgZ8emZcKtZTsGE/iX9oZE+qk+ixi+c=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=uCR2ARLWpCxwV6aA5XC40uk+6y4MJz88QtjrfINgKrTLKKxzwU69aGwyYjRLHfcBK
	 ihP1hm8FKEVjbZ7FK25JKYm6xWOz3iXDmAqa0z25p6l0AShEC2ukLjjZR1WdaFaRBG
	 auRzPoGwwu8vjQvPoSV2/OcE+ZkfjzQLUXytKYxTHmg1W7wgD3YPi58r1A1FGD7+fI
	 n+WXQZJQYInLSAq6LGR/TlvTMvBMGjZQgI4TNo586IPFNDCB4GaY1Qph7uzohu93uT
	 n9eYf/BtlvYqsDd62k/Bcg1/UMu53dWX1HTVXj9cOXZh55kRxbD0aPsWedFVVyll0n
	 Kx4Gv3D1BlbLg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFrxl-1pfhgJ2oQx-00HIYc; Tue, 28
 Mar 2023 09:30:20 +0200
Message-ID: <9e8bb69f-99e8-f204-6435-cc6e52816ebf@web.de>
Date: Tue, 28 Mar 2023 09:30:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
To: Paul Moore <paul@paul-moore.com>, kernel-janitors@vger.kernel.org,
 selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=c3=b6ttsche?=
 <cgzones@googlemail.com>, Eric Paris <eparis@parisplace.org>,
 Michal Orzel <michalorzel.eng@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Ruiqi Gong <gongruiqi1@huawei.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Ruiqi Gong <ruiqi.gong@qq.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <83763b78-453d-de21-9b48-1c226afa13a0@web.de>
 <57a97109-7a67-245b-8072-54aec3b5021d@web.de>
 <CAHC9VhR=yK72JXW3hJR+gUQtGCNpF0Bzk5RDzPZR0MunC84AUQ@mail.gmail.com>
 <CAHC9VhREfdgiCji=uEeCrc4w1kPGfnWGKnJuUYKXwTApdneSjQ@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAHC9VhREfdgiCji=uEeCrc4w1kPGfnWGKnJuUYKXwTApdneSjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OX9FeV5C3PhV0hBVF/ql8nqtnHsO9sjy/6xomMdnEH8K8ai22BE
 M7S4kVCK1wo733ecXyW4q4Xco6bCsCm9m6Asd56lxkw4vvnoP91h3dnXkXCq0wWdphQGkya
 eJzFjX9Qm5s9bHS33m0CDGwHreras+ToOMNsDwIDILF4bCgW3B1aKQDb5Z7mTpPZKhYw3f6
 xMsbQ4l6SMgIYCCGtewqg==
UI-OutboundReport: notjunk:1;M01:P0:hOgafzYJ+L8=;gu359QYdfF0t0pCPLxM7LnkxVUF
 idV4Ta0zFX3GrTovDYOpoQWencCQ/dLLC7lub11MfogKaAmT8cR45HcDhvsT1mB7osF7Aw5LC
 I3I3TtCbeTcoqdnwhzmmYCsgPV1tgpSFQWEhmDGBgtIeR7Uf7bw0INPgGJh3AIPgiUAdfVNJU
 rVcSu6DTn4qxFueqyqtZONovJ9QVt/wIMNFVwAoNp5xs75jlDYZtRceoGWLYedxLZgTxnWrQd
 /nugQCeL2A66xC04RfXRhK5dhGWqT5Grg0v5ebiTEgTSwFfJj5+Ys9XzvmWhdNr5SBX9PlRIr
 6eRoIJuSl1/wL/uZpEk3AcobV2HT47lHy5OOE8+5hB8UsknPj8TsTXC7EvgspwGSofyvZR8Ip
 EwyBwY/Rqj8+a8v8i0eS1PpbTQujc9IRJteO8ueUejuau/T3kbG8q+k+CULyooxSocWMjnjoh
 cXNRYjZNoG1L9TG1vqh9S1dXFlB+A2OrshARCDRWcD5vJ6qUfZJsGJ+cdpY/kWnjkG/oXhrPB
 2SMOGEmUUZ1ZopV97mIIa7Z2hq1BCaPDKoN4+yxXAqVrJQAfX0+2QrfDir5CehO0PnHUf+DlW
 LMoyf6An3K8yNbwn9baISN7iOllaurW0KzYtdXGUrkZGB82/QHfZx2nyF50NfoU6tPlINd7V5
 fvuwJp+j6WUdSVdAVl3+M2y5vxNgygmo1R+FbvS4GozEeOZOrWZ8z7ViVgEEpX23tJsqhqQgX
 TWewl9qVOSbf9Lm271ap0zwY6d+xFgrFNGpRqlgRfemOP/7Zr04Uk0zWsqu4rbAFUQeLolriz
 mYBdHOqnojphi0ykNXK3l2wCj6Tt4nFn5J/xfT0/e9rnN9K5T0jmZk9WClYm4yGxbvF4ePYvi
 P26/IUbCI2ale7g9lU2PI5fw4l/6wOuP6OuF6aHHAdFwDjzZ4dEJoGPRY
Subject: Re: [cocci] selinux: Adjust implementation of security_get_bools()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 967
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/9e8bb69f-99e8-f204-6435-cc6e52816ebf%40web.de>

=E2=80=A6
>>>  security/selinux/ss/services.c | 52 ++++++++++++++-------------------=
-
=E2=80=A6
> Given the fairly extensive refactoring here,
=E2=80=A6
> If nothing else it will make the function easier to read,
> and I think it will simplify the code a bit too.

I am curious which change possibilities will finally be picked up.


> I would probably also keep the combined @names/@values cleanup under
> one jump label; this function isn't complicated enough to warrant that
> many jump labels for error conditions.

I got an other impression for the affected function implementation.

Would you like to take advice from another information source
better into account?
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es#MEM12C.Considerusingagotochainwhenleavingafunctiononerrorwhenusingandre=
leasingresources-CompliantSolution%28POSIX,GotoChain%29

Regards,
Markus
