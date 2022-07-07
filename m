Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7481C43334
	for <cocci@archiver.kernel.org>; Thu,  7 Jul 2022 17:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jS4IzRvFVXno6q+Ap7ZYXYbAsoyYdtQ6mQPGsTRrlU4=;
  b=QF1TZxpLX6EhA3iXg/JTF9Hr0zoD6FU12I4fKGAYVqw9dvdS36D2yF3M
   8N5CK3pM9Kd8AsGk2WKFpoNSQT+5KsKn41R7o7p0CLjjKOcAtuWTYDbsY
   LiKnCjXAIIPV4Hb6Br1jUi/eKpPP3uSnQ60+tkRimIWhRrzIbiYkaw4sl
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.92,253,1650924000"; 
   d="scan'208";a="44743009"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jul 2022 19:10:00 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 66E96E034D; Thu,  7 Jul 2022 19:10:00 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6CCC1E0092
	for <cocci@sympa.inria.fr>; Thu,  7 Jul 2022 19:09:55 +0200 (CEST)
IronPort-SDR: 4jFmMQ1pEhRfcoD3N/LCxdiT2NkHG3uFj+8yJ1ZyoGTCHZtLBMvkXcNMry4CNr/hDKMAw7RRk8
 HRe39KCNynrwsmbJzRK+bqn9poNkbjdZZI2PUlFuhmZn4qOObnGO3627tqjI+8eYtgZ1rStTyh
 nYUsHyzLNK5lZeA9M21oOpGIfEc1Aeo5ylRreTuqgCwfuCF2b/KfFg7Y8oTRV5uYHzWI4KuKSI
 1MCKcLBlEVxChsAtw/bzWidp1TJafLw2Y0geJPWMQXOEtVwxpOY6kCgwk2X3t7DI77768Kq3Xn
 rjoR/M2a5fQBx6NC4bEWC01X
X-IPAS-Result: =?us-ascii?q?A0BJAgAtEsdihk7ASNlagQmDc4EBVi4EC0SETo5ogXcxh?=
 =?us-ascii?q?CSOKowjCwEDAQ03CAECBAEBhD9FAoVNAh0HAQQ0EwECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgQEARMBAQEMCwkHCAoHDhAFNgZeBmQEgUsEgXQLNA2CN?=
 =?us-ascii?q?SkBg2QBAgIBIx0BAREmAQQLCQIaAiYCAkwLBg0IAQGCeQGCZAEDDSMHC5Ben?=
 =?us-ascii?q?BSBMYEBgggBAQaBPwGDCx8sIlKBXAMGgREsijeERScQgVVEgTwMgnc+gmICh?=
 =?us-ascii?q?TaCZZsBJgQPAxotLxKBH24BCAQDAwcKBTAGAgwYFAQCExJTHAISBQcKGw4UH?=
 =?us-ascii?q?CQXDA8DEgMRAQcCCRIIFSsIAwIDCAMCAyALAgMWCQcKAx0IChwSEBQCBBEeC?=
 =?us-ascii?q?wgDGR4sCQIEDgNACAsKAxEEAxMYCRYIEAQGAwgvDScLAxQNAQYDBgIFBQEDI?=
 =?us-ascii?q?AMUAwUkBwMhDyYNDQQbBx0DAwUlAwICGwcCAgMCBhUGAgJuLg0IBAgENyQPB?=
 =?us-ascii?q?QIHLwUELwIeBAUGEQgCFgIGBAUCBAQWAhAIAggnFwcTGBsZAQUyJxAJIRwKH?=
 =?us-ascii?q?woGBQYVAyFtBQo7Dyg0NjwQHB8bCoEaLCsWAwQEAwIGGgMDIgIQKQYyAxUGK?=
 =?us-ascii?q?xUVHBMMKkYGIgEbAp5dIoIbEcEGNAeCFIE9gUQMiVKUYAYTLYNjknMOBpF7h?=
 =?us-ascii?q?VyRGo0ylFschRw1gUOBfjMaJIM3TgECAQINAQICAwECAQIJAQECjjY4gyEzi?=
 =?us-ascii?q?i0/NDsCBgEKAQEDCQGBVoNwAQGJPAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:aviGDqhRqfxMxBU2tz54h9IiX161MBYKZh0ujC45NGQN5FlHY01je
 htvW2mDbPqDZmv0e9t2bd+/8RlU756AnNM3G1E6+3swRC5jpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKieUsxIbVcMpB0J0HqPoMZkxN8y6TSFK1nV4
 4mq/JWAYAXNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 Nplusy9SkQ5E6T2gMsbCCB8Tic9MLFr5+qSSZS/mZT7I0zudnzx37NxAUtwMYBwFuRfWzgRs
 6NCbmlcNFbc14paw5rjIgVoruEqNsr2J8Uyvn96zDfWJekrS9bPTs0m4PcBjGdr3pwUTZ4yY
 eIjTzU+dzPaQiFUHQtPK4B5n+qVmX/wJmgwRFW9/PdrvTGKkmSdyoPFO93ecd2iXtRQhk/ep
 2Tc/m2/DAtyCTCE4T+C727qmeLF2y/2MG4PKFGm3vE6jV7Q1kEaMgU5UwCChaS/yUOids0Kf
 iT45REShaQ18UWqSPz0UBu5vGOIs3YgZjZALwEpwFzUkPuFuG51EkBVEm8YMLTKoedsHWRC6
 7Ofoz/+LRBC2IB5pFqY8aqI6yy/M24ZIAfuhBPoryNVvLEPQ6lp1nojq+qP9obr1LUZ/hmum
 1i3QNAW3el7sCLy//zTEar7qzytvIPVaQU++x/aWGmohisgOtP6PtfyswKLtKcbRGp8crVnl
 CdU8yR5xL9eZaxhaATRGY3h4Zn0u6fba2e0baBHRcF/qGrFF4GfkXB4uWwieh4wbK7oiBewL
 habuAVN6YVVMWfiZKAfXm5CI5RC8EQULvy8Dqq8RoMWPPBZLVbblAkzOxL49z2yyCAEzPBnU
 b/GIJ3EJStLWcxPkmHtL89DiuBD+8zL7TiPLXwN50/6ieb2ib/8YettDWZimchgvP/f8FyJr
 4oEXyZIoj0GONDDjuDs2dZ7BTg3wbITXPgacuRbKbyOJBRIAmYkB6ODyL8tYdI3gKlf0OvFp
 ynvVkhdwVv5pHvGNQTTNiE9MuyyB84noCJpJzEoMHapx2MnP9Sl4pAfQJ1rL7Mpw+pukKxvR
 P4fdsTcWflCE2yV+zkUYZTngpZlcRCn2VCHMya/PmogcpQmSwGQoo3oeQ7m9S8vCCurtJJi8
 uP6iV6BGcIOHl0wAtzXZfSjy0KKkUIcwO8iDVHVJtRzeVn39NY4ISLGjsgxf5MGJyLFy2bIz
 A2RGxoZ+bLAroJpotnEgaeI89WgH+dkRxMIGm7G8fCpOCOc8mf6md1MV+OBfDb8UmLo+fz+N
 LsPkKymaKUKzARQro5xM7d31qZgtdHhkL9tyFg2Fnv8aVn2WKhrJWOL3JUUu6ARlKVVvxC6B
 hCG9tVAYOzbPcT4DBgOKQBjYunajaMYnTzb7PIUJkTm5XYrreTdDhgIZ0GB2H5HMb94EII52
 uN/6sQY3AyIjEZ4ONixiC0JpX+HKWYNUvl8u5wXaGMxZtHHFr2fjV3g5i7KDFWnbtJRLg81L
 zXSiKeqa3GwAKbdWyJbKJQP9bM1aVcyVNRi01IIYViE8jYAruFixwVfqFzbUSwMpiiqEItP1
 qxDKEB/Y6mDl9utaA6vQEj0czx86NalFoAdBrfHeKA1j6Vla4AVEFAABA==
IronPort-HdrOrdr: A9a23:2tSE0qPNr07ZNsBcTuWjsMiBIKoaSvp037Dk7TEXdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhbX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KTHCUWDcurJ27O8gduVbArlvg1QpTgBUdAc0+/zZzzwLnFL
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,253,1650924000"; 
   d="scan'208";a="18830428"
X-MGA-submission: =?us-ascii?q?MDHzglYF4/4IO2jWVy1feRsxUWbAJK2ZD4mT5F?=
 =?us-ascii?q?q+PJc7dV/2TTVBEQ2hzMwASFB+SiOsQ9q32W1VG2/F8wbdX/GAfuTmRL?=
 =?us-ascii?q?dmjW7iYK89dEETahBZxgB7VW7vIwz9CZJ3a2gJB0ZiAfQVfRDvMRjWRq?=
 =?us-ascii?q?U/wEuuaK9yWDfHq3z3ZDNMjg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 19:09:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1657213790;
	bh=jS4IzRvFVXno6q+Ap7ZYXYbAsoyYdtQ6mQPGsTRrlU4=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=Q+RYyCngNENLhUXfGIPfShOZiEtseYpD6PfegcwnWazEyh3x7cKYKscuBzJEUYgQl
	 obopW+nYSntZbOBm+BXg0rT4gGuKSv1dwuxxi07InpF4fU5zX6cBIisiriiLv3/HO8
	 s5GDNx144zkIn/lphXVjeWLMj+wfpXPhknrqr1C8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([2.244.151.22]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVrg7-1nzQme3whh-00RdHy; Thu, 07
 Jul 2022 19:09:50 +0200
Message-ID: <72d9a5d9-a914-82a9-9370-9d09cc90b097@web.de>
Date: Thu, 7 Jul 2022 19:09:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-GB
To: =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <7d52b5cd-9b7a-e966-ee3d-f3343c8dcfb6@linux.intel.com>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
In-Reply-To: <7d52b5cd-9b7a-e966-ee3d-f3343c8dcfb6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ou/NX7AACz4b3twZX3YHAIXlWyYfVDR2kf4lep1LL6UNFqYVuky
 ZSuyFg1LZeXqHr0zeueyGscUnEXak7MHOaKnbnoSl+FqAGJ3yRsQuer/HhDheT8Myg/uxRq
 v0r2CzPAzZqHjE/pOD8j06j++BKK6+41YKlpsPHPnileiQMAEWv5kA69X0MgkDbfpXGV49y
 bSIN4CJ/dPFvb+i/M7cPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dRlpg6YPuq0=:Sv9oaCuUZrmHhupDJBWgm+
 ESIdFgchfO14KUFa1Gn0dv6q6npftjJ2/C48oKboPmDGDcuQJKj1l5V+GcNapoiJqObp4dnPT
 bx5zRwEzgCNCmLC5ywrGCOjF1rQbTYj7dtILH9M8Lva+LQ2S6CW+cPEi97SuPYG9PubwL3wtt
 OieCgiu+l7PBC9T8nN7sdW0uDbZmb75y+xgHYFvR16Ytwlf4bX4uGCRe6FxCHm/mpvsskJc8A
 Flfes+ENs+Re0DM3i3yEiTNuFVLAjEZ0mmkT87KVL+FFkopodPxsoKpEwtkwKR9s0Hq/RnnUH
 yWWkMhWNbFADQOnr8KpYoqFmuibxCezZ43HrvypcL3sWD2cxXGfL5jbBHznZxunw7eUR0W5aW
 gYaUAeNUukNp38XbWT8D8J0fD0tNB0IbHOr/r5AjZHVE8oUbOp5eTphibwHMPqnX9NJAT1IOK
 foOLEaezZMi6vS6nprGLi/Bb/OFiCFP3PhK1ywiKRdP/oIXYY/a2aw8gEyGIDQbtymWfjWGlu
 uSRJMlUF4jiEGTkjBFOzEOUjAiy5PkxOohOdhWUsf1k8dg33H+IXRcexuV3jik4rwhKnXqWmD
 L82Cr1JQDB+jPdudzRLWcxd85XlOQGALLViK5d52b2S9BM2vs+cZbFwP2r3ZgYArA9WNLtEVj
 JINM1aY4BzxBnQnVyywni0wpzYvx827pHf1koc4lEjgiNbTypzrk0Hl5HwPWoUiuKCpkFO69Z
 2WvBr3Iqu594uUOELA4fHJRuiHlxMcQoQduJ/tweYx8teTzIF0WeDUoSeKSB3CAF/I/INQbVt
 v8xVNq9qAsIdyKjihnUtgEXlgGD3TX75fnpQNbXaziaK92D5gBMauj6KJc4SamxXc0tZLQNyc
 Dg/V4cXl4RX2RKzikHc3LFvokrddZY+FoiQ0LfbDgTMO4lhMqbX2paGoDLBr9r9umYWAOZQnS
 QJ5kp1EH5W+UbrH/B/nKYUCN5TbAjp07zXZ2EMKAGS2APNHso6ZN54cjORqGU1TEp0WWKevNB
 j8vw2v282GTY4BAjzCuz66yG05/YDzlJTIzV3fA8SRXCaJsXglHT2E5vXIJBMWXktwmLkBA2B
 QIesITz9TJafLGCR2KfiU9cZ27sm27g315hFYqMDoOEe8yI+j5x4kvBoA==
Subject: Re: [cocci] Support for construct =?UTF-8?B?4oCcZG8ge+KApn0gd2hp?=
 =?UTF-8?B?bGUo4oCmKeKAnT8=?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 486
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/72d9a5d9-a914-82a9-9370-9d09cc90b097%40web.de>

> If I comment out those do and while lines, coccinelle picks up the
> relevant fragments (but the loop is important part of the full construct
> I'm looking for). Why does it fail with do {} while ()? I've checked the
> grammar and according to it "do single_stmt while (dot_expr);" should be
> a valid construct.


I suggest to take another look also at a previous clarification request.
https://github.com/coccinelle/coccinelle/issues/187

Regards,
Markus

