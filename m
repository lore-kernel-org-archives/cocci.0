Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0729C4167B
	for <cocci@archiver.kernel.org>; Mon,  6 Nov 2023 19:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ORHurS2Nt9uXa/Zl+JHMQ4GFqeWhQkK4BfABhbYPYOQ=;
  b=YIF7AIjLMQ63QcniofyRz5ZqYDIBOyr3/c873NueN6eJowFq904Fwb39
   RYlhcN7LuLuo0il1TyqD97R7S9GNsOzUqYT5GVPj6B0AfR2fa3oVT80fr
   WulQIsnB6BfaA5JMzEkRJoXCqg66yr164bhB2X1qcyFr3RHjxFcVupqoX
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@redhat.com
X-IronPort-AV: E=Sophos;i="6.03,282,1694728800"; 
   d="scan'208";a="134891766"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Nov 2023 20:28:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 98F6AE0CD6; Mon,  6 Nov 2023 20:28:10 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5ABBFE00B6
	for <cocci@sympa.inria.fr>; Mon,  6 Nov 2023 20:28:08 +0100 (CET)
IronPort-SDR: 65493e47_SXNro/oeBa/J0139FffTGiPwqfp3nFmU0F6DZnFj7/TS+QV
 39cRT+UOsUk42porRlDl3qzvAF8HDPIqOrbvNpA==
X-IPAS-Result: =?us-ascii?q?A0EsAABCPUllh3yFCqpaFgcBAQEBCQESAQUFAUCBOwgBC?=
 =?us-ascii?q?wGCOHqBBgQLSIxwX4hlnX6BQD4PAQMBCwEBOQsEAQEDBIR/AocoAh4HAQQwC?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECEAEBAQEiFwcOECeFa?=
 =?us-ascii?q?A2CNw4vgQxdCDkBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEwINXAEBHgEBAQMSK?=
 =?us-ascii?q?AYBATgPCxguFDUBSIJcAYJeAxGfOQGMdAEBAXaBNIEBggkBAQaCZbAQCYFIA?=
 =?us-ascii?q?YgJAYkMeicVBoFJRIQHOD5paYEPBBiCE4NHgi+JLgUCMoIig1SNA14iBUJwG?=
 =?us-ascii?q?wMHA4EAECsHBDAbBwYJFBgVIwZRAgItJAkTEj4EgWOBUQqBAj8PDhGCPyICB?=
 =?us-ascii?q?zY2GUiCWAkVDDVKdhAqBBQXgREEah0VHjcREgUSDQMIdh0CESM8AwUDBDMKE?=
 =?us-ascii?q?g0LIQUUQwNCBkkLAwIaBQMDBIE2BQ0eAhAaBg0nAwMTTQIQFAM7AwMGAwsxA?=
 =?us-ascii?q?zBVRAxQA2wfNgk8DwwfAhseDScoAjVDAxEFEgIoAxkrHUADC209NRQbBkAnn?=
 =?us-ascii?q?hGDXHtFAYI9sDCSMYI5BwOEDIwBlQgEFjOEAYFWkUkMOZIbmD6NZYdCkwECC?=
 =?us-ascii?q?gcWgWM6gVxwFYMiCUYDGQ+OIBmDX4UUimVBNQI5AgcLAQEDCYkigikBAQ?=
IronPort-PHdr: A9a23:JF/IcxVEKGMTIbH2Eqee3hkvmlHV8KwzXDF92vMcY1JmTK2v8tzYM
 VDF4r011RmVB9WdsqsYwLOP4uigATVGvczf9ihaMdRlbFwssY0uhQsuAcqIWwXQDcXBSGgEJ
 vlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+I
 A+5oAnPtcQam5ZuJrs+xxfGv3dEZuBbzn5sKV6Pghrw/Mi98IBi/ihKp/4t68tMWrjmcqolS
 rBVEC4oOH0v6s3xshnDQwqP5n8CXWgTjxFFHQvL4gzkU5noqif1ufZz1yecPc3tULA7Qi+i4
 LtxSB/pkygIKTg0+3zKh8NqjaJbpBWhpwFjw4PRfYqYOuZycr/bcNgHQmVPQ9tRVzdZAoyic
 4QPE+QPPeFdr4bnplsOqwa1CQ2jCe7rzzNFgGL9068n3OQ7CQzI0gwuEcwTvnrXotX6O6UdX
 u6pw6bV1jjDc+9a1C3h5ITUaB0tv/eBVq9wf8rLzkkvEhvIgluMp4zkIzyV1v4Cs3KG4OF9V
 e2jkWkppxtsqTarwccsjJfGhpkbxlvZ8ih52oQ1Jdq+SEFlet6pC4FQuD+HOIt2WMwiX3tkt
 zo9yr0DoJO2ejUBx5s7yRDFcfOHb5SI7Qz5VOaXOTp1mnFodbOiixi87UWt1unxWtW73ltIq
 idLncXAu3AQ2hDO6sWJRPpw8Ee91TiA1A3d6v9JLV0wmKfUKpMszbE9m5wOukrNGS/2nV/5j
 K6Qdkg84Oin9fnoYrX8qZ+ALYN7lgb+MqE2ls2xBuQ4KBUBX3CB+euiz73j5lf1T6lNjv0zi
 qXZvo7VKtkcpq6jGQBVypwj6xG9Dzi4zNsYgWMLLFVfeBKIiYXiJlLAIOjgAPuigVmgjC1ny
 +3aMrH7H5nAIHbOnK38cbpj5ENQ0As+wNFF655JCbwMIuj/VlH/udHWFBM0MQK5zuD6A9tnz
 IweQ3iAAqqBPaPSr1CI4uUvLvGRZI8OoTr9MP0l5+L2jXMghFASY62p3ZoJaH+mBPRnI1yVb
 WfyjtoOC2sKuws+TOn0h1KeSzFTfGqyU7gg6TE8DYKqFYbDRoazj7ydxCq3A59banxcBlyRD
 XvkbZiIVvkCZS6IP8NtjDMJWaCkS4A71BGusAH6y6BgLurR4iAYr5Dj1N9z5+LNjhE/7iZ0A
 NqA3GGNVW50gnkESCMx3KB6uUB9zEyM3rBig/NEDdxT++9JUgAiOJLB1+B6Ecz9WhrdfteVT
 1arWsmpATYtQd0twt8DeF19GtWnjhDbxSWmGb4Vl7qRBJw16K3QxXbxJ9wug0rBgaImhFIna
 spJL2yvwKBlpCbJAIuc2X+YnKajb6hU42josi+hymyDpwsQBBRyVqPIRlgFa0fWpMi/7UTHG
 ez9QY87OxdMnJbRYpBBbcfk2AkXLB+CENHXYmbq3ny1GQ7N3bSUKozjZ2Qa2izZTkkCiQEau
 3icZkAlHin0hWXYAXR1EE73JVv2+LxkqnS9Q1Qc1QyGb0R9kbGy/01dnuSSHssaxalMoyI9s
 3NxFVe50cjRDo+apQ1ncb50e94x4F5bk2nesl81JYSueoZlgFNWaAFrpwXu2hFwX51HitQvp
 Wg2wRBaNLndy1Zdb3aU0JTxJLDNOyyrpkzpbq/T11rXy8rQ8aAKgBghg3PkugzhVk8r8nE8l
 sJQz2PZ/ZLSSgwbTZP2VE8zsRl8vbDTJCcntcvS0jV3PK+4vyWnuZphDfY5yhumY9ZUMb+VX
 A70HcoAAsGyKess01G3ZxMANepW+eY6JcSjP/eB3aeqOq5nklfExSxd4od731mk7SdwSufUm
 Z0CxrDQ3weKUSv9kEb0qtr+yshPYTAfGHb6yDCxXdEJIPQqO99QUiH3eZHko7c2z4TgUHNZ6
 lO5UlYP2cvyPAGXc0S4xgpIk0IevX2gnyK8iT1yiTAg6KSFj0msi6zvcgQKPmlTSSxsl1Dpd
 MKujdccUVOAdQUllBK5o039wuIIwcY3Z3mWWkpOcyXseit4UKy2u6GqecND6Jo09y5QVa7vK
 UDfQbn7rRwA1irlFGYL3zE3eQahvZDhlgB7gmaQRJpqhELQYto4hRLW5diHAOVUwiJDXy5gz
 z/eGlm7OdCtu9SSjZbK9O6kBSqtUZhacC+jyo3l1mPz/29tBxCkt+q+lt3uDU4x1iqz29RxV
 CrOpQrxecGyiPz8aLohJxIzQgamt4JzAclmn5E1hY0M1HR/5N3d5ncBnWrpcJ1a1a/4cHsRV
 GsOyt/R7hLi3R4rJXaIyoTlE3SFl5I+P5/jOiVPgXl7tpoWW8L2pPRekCB4o0S1t1fUaPl5x
 XIGzOc2rWUdm6cPsRYsySOUBvYTG1NZNGrijUftjZj2oaNJaWKoabX12lB5mIXrFrOFpAxHc
 Gz0dpcrAWl76cA1YzeumDXjr5rpftXdd4dZrB+TlRrbp/JYJJI4irwBgi8tairt+HYizeA8l
 xln25q36ZOGJ2ta96W8GhdENzfxapB2mHmlneNEk82RxYzqAoR5F2BBQs7zVfzxWmFapbH9O
 g2JCjF5tnqLBe+VA1qE8Ek/yhCHW5GzayPOeiNfl4k9AkDDfAoHx1pNFDQiwsxgSF/slJ2nK
 AEhoWlOrl/g9kkVlLIubUWiFD+Z/EDxNVJWANCeNEYEt14aoR6Nd5XEvqQrWHsEtpy58F7Ud
 TTdPlwOVDtYHBTDXQyrP6Hyt4Cfq67BXqzndKCIOfLU9Yk8H7+J3c79i9Q9uW/daoPXeCElV
 qNz21IfDykpRoKEy3NfF2pGzGWWNYaavEvuo3wt6JriqLKxAFKpvNLVbtkaedR3p0Lv0P3Fb
 bPIwnwheXABj8hExGeUmuFOhhhI1n0oLmD3V+xH73aFTbqMyPYGX1hBLXopZI0QqPtsu2sFc
 c/D1oGsh+4+1KdzUxEdEga40sCxOZ5TcjH7bg+aQhbTcuzBf2WDwtmrM/rtGfsL06MN60H24
 XHBSyqBdnyCj2W7DkH+d7gW1mfCZkQY4MbnK15sD2PnUd7rOAajPoQxlzA6wbQowHjNMCZZO
 Dx4OSuht5W26iVVyrV6Em1FtT9+KPWc3j2e96/eI4oXtv1iBmJ1kfhb6TI00ekd6iYMX/Fzl
 CbIy7wm61i7jumCzCZmWxtSu35KgoyMp0BrJaTe8NFJR3/F+BsH6WjYBQ4NopNpDdjmuqYYz
 daq9uq7MDBZ79fd5tcRHeDJM4ecNWY5dBbkHD/KAREUCGfxaSfahklQm/iJ6jueqZ174pngl
 ZwSS6NKAVw4EvRJbyYtVNcGIZpxQnYlievC05ZOvCL49UKKApwA4sOiNLraG/jkJTeHgKMRY
 hIJxei9NoEPLsjg3FQkbFBmnYPMEk6WXNZXoyQnYBVnxScFuHV4UGA33FroLw2353pGX+S2m
 Rg7kSNkbOgt/Suq6FAybAmvxmN4gAwqlNPpjCrEOib2N7u1VJpKBjDcqlN0KZbnW0N5YAmzg
 0F+JXKdHe4XirpleGtikxOaspxKU605L+UMcFobwveZYO8t2FJXp3C8xENJ0uDCDINriAogd
 ZPER5Noxhkmd9spPencKa5I0FVKl+fX5HPu0+E0zQQXPFpL+2SXKnZgUKMgLLQqJyO0uOdr7
 F7b89OmUHIBW/ojvrRh8UZvY4y9
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:iAVqQKtv/n/xgiwpkgyB3hnf7skDW9V00zEX/kB9WHVpm+ij5r
 2TdZUgpGXJYVMqM03I9urvBEDtexLhHNtOkO4s1NSZLW3bUQmTXeNfBOLZqlWLd0LDH6xmpM
 JdmsNFeb7N5DZB7foSrDPIderJbbK8nZxBAozlvgxQpdUAUdAZ0+8UZzzra3FLeA==
X-Talos-CUID: 9a23:6iLUqGPoKXFSF+5DZgtbqVNISvoZcyfj41LbB3SUME0zYejA
X-Talos-MUID: 9a23:sKLRjwu2swUnFd0brM2nnW9uKsZHyZ6XK0UXjbkpkPuYLxNbJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,282,1694728800"; 
   d="scan'208";a="70675667"
X-MGA-submission: =?us-ascii?q?MDEnuZCXyzCqQlMk4u9q8YleG8lYQ5X3j7hFsF?=
 =?us-ascii?q?/l09BhKoCxicG1S3gNH9ugxdp7WO3FgDRw57qVZRfIl7WXbzf9Q2QDvU?=
 =?us-ascii?q?alyTlQpmHX78t205SdTAHKGkz7juFi57nbBDejuqGOFtvh3czgSmSohc?=
 =?us-ascii?q?je6Mje5oUMX0fxsJWaL1vlHQ=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 20:28:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699298882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ORHurS2Nt9uXa/Zl+JHMQ4GFqeWhQkK4BfABhbYPYOQ=;
	b=JzWtXKA/s47c75c+Q30mJpBMPjsxciQ8+RGv9Xig4cHp7gZwb4lG0b9/cvm5i5g80lDXL3
	5L+CNzj65JAqxFJWQhdV81TeGWYxKR5lyyaUCAcLFjaCv40faEQP0vW7JlypBgQfF1Dws5
	eZPl12V1jM1FvpGO0BQVzD+6VknXX+g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-xz8KkNSXMxOGNPf0oKeHgQ-1; Mon,
 06 Nov 2023 14:28:01 -0500
X-MC-Unique: xz8KkNSXMxOGNPf0oKeHgQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6AA928EC100
	for <cocci@inria.fr>; Mon,  6 Nov 2023 19:28:00 +0000 (UTC)
Received: from localhost (unknown [10.42.28.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A1C4A40C6EB9
	for <cocci@inria.fr>; Mon,  6 Nov 2023 19:28:00 +0000 (UTC)
Date: Mon, 6 Nov 2023 19:27:59 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: cocci@inria.fr
Message-ID: <20231106192759.GB19414@redhat.com>
References: <20231026075755.GA19414@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20231026075755.GA19414@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [cocci] Report that Coccinelle doesn't compile with Python
 3.13.0a1
Reply-To: "Richard W.M. Jones" <rjones@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 1292
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/20231106192759.GB19414%40redhat.com>

On Thu, Oct 26, 2023 at 08:57:55AM +0100, Richard W.M. Jones wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=2246276

FYI:

https://bugzilla.redhat.com/show_bug.cgi?id=2246276#c2

  "The use of _PyObject_NextNotImplemented actually comes from
  ocaml-pyml.  There is a new version of ocaml-pyml out that drops all
  support for python 2.7, including this symbol.  I will build it and
  rebuild coccinelle.  That should fix this bug.  I will do mock
  builds first to ensure that is the case."

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW

