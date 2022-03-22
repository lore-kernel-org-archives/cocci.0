Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7463BC433EF
	for <cocci@archiver.kernel.org>; Tue, 22 Mar 2022 19:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=fG6L3m4S2K2nWmQ8h0jYn9Hbw9lNX5mus4AOwpgPsoc=;
  b=Gn1tmm7BUeXIA+SeV5flvGb+y7a/QjXJUOSfrIIwO+d6e/Dk3D6BDs5O
   uO6NhqK4XbJwKMVYe2vlFv4tuRCWzQiP3Bsow/HMgBgqV3ftnk6E4UPxS
   qL6tteaVSJ78PLKOemk71KShrZ8yL8rmlz39yu6OVmMAV5oX2/XTkojSj
   0=;
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
X-IronPort-AV: E=Sophos;i="5.90,202,1643670000"; 
   d="scan'208";a="27553564"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Mar 2022 20:27:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8AB3AE0219; Tue, 22 Mar 2022 20:27:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6AAA0E0069
	for <cocci@sympa.inria.fr>; Tue, 22 Mar 2022 20:27:04 +0100 (CET)
IronPort-SDR: XLppURFDweqCXiwKCsIa18IURX9corAF+s/nhlmUEJRKfKv4sNfqHYOWyN2EY2Mrff0yhLBdBM
 /z1IPO/aLeZlnvT1hBucG+QFiZaySDv8CnEpf8f8pAZ+MUxGCbJ/XPgClCi2++HjDC2cZvaCt8
 ktfmTZsNXzLLW1CsksSs49wVJUJlBvIN9EdOoocBJhqaQDwJdKoXPkXAAqtrtkn+63ZTXkkx8E
 hmhrlXy1pgRwTNmXO+2uNo0wFkMtC8et5CJCAd4Fw+2gHDBZQWVuQzJev1QbiPDc/Kd+rsF8zO
 3711DBvch+ob3NYja9mKiTKY
X-IPAS-Result: =?us-ascii?q?A0CtBgC+IjpihwMP49RaHQEBAQEJARIBBQUBQIFaAoImg?=
 =?us-ascii?q?VUrBAtEhFSIKIZLgiiLJIcYiiiBewsBAwENEgEtAQIEAQGFBwKERAIdBwEEO?=
 =?us-ascii?q?AINAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwNCQUICgcOE?=
 =?us-ascii?q?AU2Bl4GZASBSwSBdAs0DYI1KQGDZAECAgEjHQEBESYBBAsLGgImAgJXBg0IA?=
 =?us-ascii?q?QGDAIJlAQMNJawrgTGBAYIIAQEGhEgfLCJSgVsJgRAsAY5JJxCBVUSBPIMDP?=
 =?us-ascii?q?odfgmWYEIEVghhRoW6eRDQHghKBOoFBDJ4RBhQug2KSWw4GkW+WW6cCgg+BZ?=
 =?us-ascii?q?zMaJIM4TgECAQINAQICAwECAQIJAQECjh0ZhAyKLEA0OAIGCwEBAwmFRwEBi?=
 =?us-ascii?q?wkBAQ?=
IronPort-PHdr: A9a23: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
 DTfpJhirgP/+gFq4iVqWlxCp2QT7L8=
IronPort-Data: A9a23:ah3sX6m/68Ork0JdjWkjzr3o5gz5IERdPkR7XQ2eYbSJt1+Wr1Gzt
 xIbC2iCPvfZYWb2Ld50a4+2oRlSv8LUn9ExHgA5+ygyH1tH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTres1hlZHWeIcg944f5Ys7N/09YAbeSRWVvX4
 4up+ZeHYzdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /1kspyhaAcHbpfUmd1HVhNKAw10P/NJreqvzXiX6aR/zmXDdGbwhepjBgc6MOX0+M4tWDsIr
 6ZHbmlQKEvra+GemNpXTsFJj94gMdKtEYcRoHBmwhnGAPxgTZ2rr6Div4AFgWxt258m8fD2W
 OoVe2JENTP5cRwXK2cnNq95p+CHvyyqG9FfgAvI+fRuuja7IBZK+LPqO9HUUsebQN1c2Eeev
 GPPuWrjaiz2L/SazieZtG2hjKnDkEsXRb7+CpWR8f57oV29llYLCSRMUFGpsdWziBCxDoc3x
 1MvxgIiqq079UqOR9b7XgGlrHPsgiPwS+a8AMVnsF3WkPa8DxKxWThdHmQphMkO6ZduLQHGw
 GNliPvFKFSDWpWwTnSB/72dsCna1cM9cDFePHdsoect2dnuoYc3hxTDC+5tGaqn5uAZ9Bn1x
 C2W6jczjfMfgKbnNplXH3iX3lpARbCQEGbZAzk7uEr7t2uVg6b7PuSVBaDzt6ooEWpgZgDpU
 II4s8af9vsSKpqGiTaARu4AdJnwuaraYG2D3QY3TsR4n9hIx5JFVd8AiN2ZDBg4WvvohReyP
 ic/RCsMuM4NZyHCgVFfOd7gWplCIVfc+STND62IMIMXPPCdhSfesngmZEiM0nrrnVRkmK5XB
 HtoWZbEMJruMow+lGDeb75Fj9cDn3lirUuOG8yT50n5gNK2OS/NIZ9YYQDmRr1ovMus/l6Pm
 /4BbJTi9vmqeLajCsUh2dVPdg9iwLlSLcyelvG7gcbYe1s4Qj59U6GNqV7jEqQ895loei7z1
 inVcidlJJDX3BUr8C2GNSJubq3BR5F6oS5pNCAgJwj6xHUpJ4qitf9Ne5wydLgh1epi0f8tE
 6hbIZrdWKwXR2SV4SkZYLn8sJdmKkahizWOCCz5MjIxSJhtGl7S8dj+cwqzryQDV3LltcY3r
 7C6+BncRJ4PG1ZrAMrMNqCwwln3sXVEwLB+WE7BI99yfkTw8dE2enKr0aJte5kBcEyRyCGb2
 gCaBQYjidPM+4JlosPUga2krpuyF7UsFERtH17dseS8Ox7c8zfx2oRHSuuJIWvQWW6oqqWvY
 eJZk6P1PPEdxQ8Yto1hD/B0wKh469a2/+1WyQFtHXPqaVW3C+o8cyfcgpQV7vVAlu1DpA+7e
 kOT4d0Ea7+HD8PSFgJDLgQSaOneh+ofnSPf7KhuLUimtjV7+qGLDRdbMxWW0XUPKbxoLMU6z
 O1ntMNPs16zjR8jM9CniCFI9j3QfyJaDPh97skXUN3xlw4m6lBeepiCWCX415G4bYkeOEcdJ
 DLJ1rHJgK5RxxaZfnc+fZQXMTGxWXjTVNF2IF4+y5Chn93Ymrko0RcX/TlfosG5CPlY+7obB
 4SpHxQdyWayE/NAm8VJGWyhc+2ELAPM4VT/kjPli0WAJ3RFlQXxwKkVJuuHukwUm46Zkv634
 5nAoFvYvf3WkA0dE8f8tYOJaxAucDCpyjD/pQ==
IronPort-HdrOrdr: A9a23:h1ZER6h9HS7Y4w2mrjxeqAAwdXBQXv4ji2hC6mlwRA09TyVXrb
 HLoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykesS+Q2mmF+rgbsbu6GeyT5Ns31B1WPHpXgkxbnn1E4j/wKDwKeOHMaKBSKK
 ah
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,202,1643670000"; 
   d="scan'208";a="27553557"
X-MGA-submission: =?us-ascii?q?MDGEwK/hv6Iu3vh/f2b1VFiVKcwwpUIexJ+e34?=
 =?us-ascii?q?Y4bp7tnThSFz24d3SknpGP4ukUTBjwqYID/X4exPYa7F5+ThUCE8L9Ns?=
 =?us-ascii?q?Qlxcz3NDBPa2xYoK41URwhq7ZPx3BR7ShEG0Th05/STjBxJAjF3iXnaM?=
 =?us-ascii?q?o19w2T/1S+quXKbvolsJn7Aw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 20:27:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647977223;
	bh=fG6L3m4S2K2nWmQ8h0jYn9Hbw9lNX5mus4AOwpgPsoc=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=n2XZHZfTeEl7xGFwWuzDoZ0gW3dZWzqeqQfNlQU9zTCPs5gxGr3CSdETFw+hcqEnC
	 Ufj2Bqgm1lPIRLzVaRPH6ywlV5XopTW/PsryrDkqHACXxY9CIHRVP5mgU7VmpxFj4g
	 v+71NRhgI/td2T8x/ok2AkDM6s7k2J92Lq/VqecI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.118.185]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ma0Tg-1ncIct0WGK-00WKtD; Tue, 22
 Mar 2022 20:27:03 +0100
Message-ID: <94c5831a-2d58-205e-a02a-db2976ba6329@web.de>
Date: Tue, 22 Mar 2022 20:26:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
References: <4fc9237-ca2-518a-3221-9770f6112c6@ewheeler.net>
 <b77b2358-50fb-69ff-3205-52781e6bf405@univ-grenoble-alpes.fr>
Cc: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b77b2358-50fb-69ff-3205-52781e6bf405@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Q3M2+VvqInR6aaTdgy4+IpjlAPNDpYGxEGeJ7kMFX+mMOpjOK3n
 wRGI0AG4NdrOjPer4dIkMPjLa6E3GgemQrovNYE/8kDoQsuq3AATLASqBgsGxoNhy1b/rNz
 7OpFZPiymsbBKMHqldKgww0/Kl/tmpjqulLu33zeMHiN22tnwc8cfXmzCqC7LUDiB2wTpfn
 g3jlARrP21s/B3zQkCgFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6YkbQ+GNWLs=:LqZ8qKAp5W4qlWMjyKqlWz
 8L3FnSrOW8VsJqRzEALSSPfywYeKZXebhK77ISw2MwKpLRaVy4Pk9YDaFcMFbez2aADSStpZG
 Eugqv+luzX52wtN4zXIfF/76uHrVSN/7lHXtrUF3Ks0MboNM0rSOtcwQFHL+naWgXlIRoEXP5
 TjyZvMr2izLMYTphsdYYeQ+ax5C7EXomD+t0HpSfZXHEEcEhKbHsBgKx7LHNZUGwJaUMvnurf
 1T7RnU9zOXgbUL7FtAdvy2PzYm0utzniJ5VUL1f//yhxEujDgE0+4a0yW5iPuwlm27hScFi0O
 fBssPGXE80/gY/gMAFJ4jBO5z+0CHc+htYspN2B0O09NvyKAIqmSvwFAq4coJJVuAqGgVP4hG
 mgz8i/Ilxkka/PTdxyh6Za8kSFLaKNgLCAGcHPsRWpGIbZ+lR3/iWTfsKemab0JbYbpqHwGi+
 auEr5x1gqi9PcvxhLxX/kuO/Mlup06t0SiTlKEJYeJzRTc0DWN4KFJq8eq3Dop+TxQYdqeHUE
 /j6QUV7aw5/LvpyUwDfj2CBwduVNE7+FEPxE5RKpP0B7zbCUa9rhVUCmnO3FrlMAGISwzU3gw
 eZsukvGvGkd9glHbWdgzBMQW5mfcyMheUfYw4zwP9+9hmjGoP6HDA+s5f6A7lV3O263oBpX4j
 TrpPvNqiwCpbfKSl2EwTvxwOlG4AKVnYje7Z8XBmWVpU1G95gE1fWX+qTWuTqgz35UfIFv1Oq
 6QNnI8IqZlOUKn2l6NlTZvWL280sRRbT9nXA0Oxp9Jl1UMwhGOEJ3jIaDhJFKQv31jL2jWNRR
 9qzNWS672V60oZ9j3elfZiJCdgtS0lxtVj8sXMlCVdAUKApBAjQQ6BRQY4bKVuxXSLvOD1VAw
 z5e9OC/Lg0pm4yY/G9xvHivgOVVLR7iZMcfoTRxFP7ioH9pHlOM7/Pv0jqJXwmI+RCil+ZBVB
 50mqX5aNdcrkXzsn9zFDYeF8+rs92qiWx8YvTE6LJUw8esKhIWWCJEGq/tMXgvQwN4C95fk+0
 l8CsdrObgaQIA5I6sPj9HlvvPZuBlCyVT7ZBh4FKgnG9YKgIuoC6wrVERtX4zn/wPGkxPepm6
 JcbV9IlHpf8BZw=
Subject: Re: [cocci] Does SmPL support regex groups?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 285
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/94c5831a-2d58-205e-a02a-db2976ba6329%40web.de>


> For the record, is it the expected SmPL ?


Your SmPL script variant points specific development ideas out.



> @script:python py@
> U << fu.U;
> C;
> @@
>
> print U # Rewrite U to extract the extension
> coccinelle.C = cocci.make_expr("\".gplot\"")


I find that this code part would need another case distinction
(after the use of a capturing group within a regular expression)
so that the file extension will be extracted as expected for the
desired source code transformation.

Regards,
Markus

