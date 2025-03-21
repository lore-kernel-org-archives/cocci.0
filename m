Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61DEC36002
	for <cocci@archiver.kernel.org>; Fri, 21 Mar 2025 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=J9S4mvdJESqeXsOeTOkwG8SMCJok7Z8IImF7k+Attdk=;
  b=agSpaUwMSTS3BfOFF0sgM4VkiD7UrOGySp7Kf4XMpyZwrm2yDCyvHm7t
   W8ZHRax4d85z6S3mNjnZuhN+LZo63M/0mvXY18lr/O3ENFttgLjeBh0EE
   RoHqLjhXA43fNqw3a/8blzf11SWBaPreJVVVwi9U6MbO1h6OMMPRolTxD
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="214140545"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2025 14:43:57 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 24C58E0D1E; Fri, 21 Mar 2025 14:43:57 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1038EE007A
	for <cocci@sympa.inria.fr>; Fri, 21 Mar 2025 14:43:56 +0100 (CET)
IronPort-SDR: 67dd6d1b_iLiYcd5ZIthNaM1KpTLntKLOhQAC1n8J9i02xvNyFakgdX0
 r47wdRPHMqOEtf5rjHT5IlnMet80QCLJY22ohew==
X-IPAS-Result: =?us-ascii?q?A0FkAACdbN1ng07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAQGCQn1aMwQLSAiETo9RgXQwhDuPDoh1gVaBfg8BAwENOwYBAgQBA?=
 =?us-ascii?q?QMEhQACiyICHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQEBOgcOO4V7DUkBEAGCBwGBJIEmAQEBAQEBAQEBAQEBAQEBAQEBFwINO?=
 =?us-ascii?q?kQBAQECASMdAQERJgEPCxoCJgICVgYBFAEBgn4Bgi8BAw4jBw0GrjKBMoEBg?=
 =?us-ascii?q?gwBAQaBWEHYQx8sIleBZQMGgRouAYVsgmMBhieDQnonD4FVRIE8gwM+gmEEg?=
 =?us-ascii?q?V6DW4JpgjOEHiVnjBmENIRMhF1XgnGNG1J7HANZLAFVExcLBwWBKUMDKjQxI?=
 =?us-ascii?q?4EiBTQ0DjgpgWNpSToCDQI1ghskWIIoagQFgSSCNoQ+hECFUIIRgVwDAxYPA?=
 =?us-ascii?q?YMfdRyDS3U9hGMtUIJFHUACAQttPTcJCxsGPaNPO4QjgQFXApkKjGOicjQHg?=
 =?us-ascii?q?jiBZoFjDIoplTUGEy+DcAGTVQ4Gkn0umFAijWObLoFtATOBRBEHMxokgzZPA?=
 =?us-ascii?q?xkPjiEZhBSEYLYuQjUCOgIHAQoBAQMJhUYBAYUnhS2BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 IT7qa2ogK12dKIpLftdRg==
IronPort-HdrOrdr: A9a23:c6Z0Yalr38nB9m1kkBoidS/kSiHpDfL43DAbv31ZSRFFG/FwWf
 re/sjzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:RS9Wh2AJQ6k8Eiv6EyZexnAaJeckSHHE6SeKOQjoWCF4Q4TAHA==
X-Talos-MUID: 9a23:1SWrzAWMbni1hYrq/C7mqgB5Zf9a2vXtB2wyobInhJGoFwUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="112259956"
X-MGA-submission: =?us-ascii?q?MDFurytwZGZxGRjuPSLjkhO2PmXGJJYyTK9Laq?=
 =?us-ascii?q?KFenrLjbFXodoTR/dPX35y0hLB4jhDlrDYEM8puMCeFfeiOZTZSbOmgF?=
 =?us-ascii?q?eDIdHsBgUADGRpEFt/TzcazWKl/sVfXTnkoZFr53FP5cPqZJzgOtUh+f?=
 =?us-ascii?q?e8xo34mTBCFhux82ozjv/JYg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 14:43:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742564634; x=1743169434; i=markus.elfring@web.de;
	bh=J9S4mvdJESqeXsOeTOkwG8SMCJok7Z8IImF7k+Attdk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FkkFajqZaRmCj3fJZeTPLzSZ7/godI5pfisWXxbUd05X8kZhyWJT4UocHHyhNGFX
	 hye3m46UCEoRUkXgKq3AS2dJ8TKSY77WB1wa2x1QGRoiCJUg24YHnocb9KIKxNCSJ
	 9gExBI/QW4qL7YRayu4Mu9ong4a1xCg3qBJ3uHEfY8YfNEPxuZElzds+8HXtVGoSf
	 H46Bf0mZwW5ezLsR5LrnXpKzs5iYCqxRt9UPtqgRQn7tSKdO2w02brvD9n1iRsf8Y
	 ZMkvs94Lv+On5nGEj9Plkc52Ij3tU02hbVLNAUTQlSgX2ACE/0bt3ZjdxVzy+tDzG
	 v8LiObr6ug+xtXtEdg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.36]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLAVc-1teVWC00sk-00IY9o; Fri, 21
 Mar 2025 14:43:54 +0100
Message-ID: <93d554e9-7b42-4d1c-b65d-5be649f93f5f@web.de>
Date: Fri, 21 Mar 2025 14:43:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: =?UTF-8?B?SMOla29uIEzDuHZkYWw=?= <hlovdal@gmail.com>
References: <99c55fe9-b23f-a6c2-575-9a856a8a358c@inria.fr>
 <CAACXqO9vVrOFyrcZhKZxvO=H9C7Kp-x2jM9O_mCTd=RA0mQ5XA@mail.gmail.com>
 <634d9530-6d94-49ae-8abc-7b93d6c4fa7e@web.de>
 <dd7cb31e-bf5e-2cd3-3f62-1e572c72da0@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <dd7cb31e-bf5e-2cd3-3f62-1e572c72da0@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KR+pj8IDLa4Y9961OrWRSaX48wZhJHioVyzqGC9rvuzvYB9OJRU
 CxMBqGI1AsBipeR0gQ+0lJZdf/ZCCDg26C+/lqgZkrF3mNDRi21Wkt+cc+0E5kXt6xvsef/
 9qcW5fAsPnNABgmtEIIzbhIpBdlmJ2gjA3RVlzlr4R9qTxrWYwHf1Xxw7HuZEVmoQwTUKhx
 mKFjsC09ur++Q33qhUNxQ==
UI-OutboundReport: notjunk:1;M01:P0:MyoPD6quTGI=;564vuqz6FnYT0eUHIVAo+abPa1h
 AmSgFsDDH6D+NJi/loEDcwj07ha3mpLUFhrsRiNgkE03prjvAVeFvJiB34A7STZZWalRvT0PI
 9H+YyLn7iDdHGlHodGYvw+8sull8Fzr0FLetUf6acPF7t905zMkwnXHNBLL4MFhgipGuvMhEN
 3NRWSKgWbRqMHcXt6O3fJM9Im5rj6PkuA1DxuFOpl1RPomHfTOoxdkJOXE5Mx4xFYQOo1IRAd
 FsLOCU6FuCkJoKg/qDn4/wS8/at2K8PGDSUXgrunxPT21ucIXpp1G2VOfJCl9WMIYDhtwXeoN
 KJ39lF4NjVXeupsRBxPfdmCTvQH1e2TMXKi95iIM9XogMaAd2uJe7QvjleVoyeNk/OEBdLpgW
 I05zMITecfEPQLPV1vG8Yo8cA935f1te4iwMzJVX/cCRvyO/LoEayAmbPBvG6Kw2L6Ewcrw8K
 5u8+Q5lx5Ntjb5tUBBUIrVm9yDqRlWM23uZZamR6fMlLX5nnvcvoK6KrdKm2hjrfV35PsUJ4Z
 Y1abwoLPGXpqHcz/7UjYUldEKBwDEQLGN87v4QXUOhvtrjnNY63irUxFi7pfbl45sBBB3y+6V
 wwwTJJdsfRCb/GA6iPdkrAoeCZXZY1zfGM5S/TqYo2kOCvcTwAlG+aGPYvT/6Ul1qdXc+t5/b
 gdQo+rldR5Fucb5Eo2kAUjn1v1OT8rgZAyaDw6VUPmCde6ochGEdFnGxM4pdmKUlpz4Eyngwg
 m1+S9OWFaEUe72/epmoboBSTHz0JcFabK61AWy2FT/KQUb4IT+hk+rgpUZrEgsgxQOjiBpVJN
 ZScDvWfYfrB9vVE6rurXvA8MEiRmOq9EmYexXOXUxnExPrLMXBvK9KmppYGcldcst0eG47Jm+
 eVnZVtpqYSjVNM53xT2bv2wQdqBzSLqv4r/b+/BpMxfFCSloyasMV+g+wtZBiHu1zUwDm8cBI
 czm85E4C5D+A0GeNU0WmSbESNboTUZgnadxTnZE65Vxwq5zUvRvHk0K13uWYYj2InmnqO+S1E
 vxyLNsWuyfvMRkQSTAst2sfRE+HuBrhTsktFjdxDvHsJnJJv/iuz/k1gz55H0vq4bm1Wh0qBM
 tdpb0MF8nefVFxTC4KH3BNq0ShI7Y62+52Glz2Ai3kUU6J5fYhvi4A85uuIT/v5RllSgZQxG4
 P7cKvnKOZvQO0LzdI6vVY+1AQj8zzZXz3/81PUrUGBK3R3jzQK1SipYJa9uatonCj96yqOkgk
 XRXRvnwf0dNLRnzTjyM2wur4gd8l0UFlc8oDGIg0JddBZOIrNS/0Zu3ijTYcnoco24olB3K0J
 Yz53oS1iiOV3hq2Ujn70dxoAXEetRBzKnuk0p/r+m0rjIFUwVv+ZTQX6l5E57L05bNATGVEYJ
 oKl8mGK3HG9TypRuzuPQ/et3bmaafltMwXH7IHc/pK7DtnbrK+1loUTZMWW10XbUdWGbZSJBC
 KHluxXWX6vaQRke40J++Xv5ECqWZnsG1j6UTGOOW3rGRnhn7z
Subject: Re: [cocci] scoped_guard
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2668
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/93d554e9-7b42-4d1c-b65d-5be649f93f5f%40web.de>

>> https://docs.python.org/3/reference/compound_stmts.html#the-with-statem=
ent
>
> It seems related, but I don't see a generic name that would be suitable
> for a metavariable type in that documentation.

Would the term =E2=80=9Cwith block=E2=80=9D be too generic?

Regards,
Markus
