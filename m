Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BF3C433F5
	for <cocci@archiver.kernel.org>; Sun, 13 Mar 2022 00:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xMB0ZrIGOQTiC1BhJhTOB/40JVoBNlh5uv3krylFxzs=;
  b=A47GcpPQr8UNy+0MSaxZPR9abWpX9Mpu3NLqQUnL30AsXsxsAnSLKBIn
   u+glej4GbCDvKmj0EuzQfHJwwMPMF5X7s2DRL+i4ylV2f2K2wlpUYi7//
   q0HtmsavxpyUibOgDII5Qfeo9gR/ArET1u+cPS+E4O7BE2GHPqo1/rDqm
   0=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.90,177,1643670000"; 
   d="scan'208";a="25822997"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2022 01:53:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1562BE0048; Sun, 13 Mar 2022 01:53:50 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4703BE0045
	for <cocci@sympa.inria.fr>; Sun, 13 Mar 2022 01:53:46 +0100 (CET)
IronPort-SDR: bz37MiLtPgnZ2cKfYYzE7OXmGZ0nZcDenaQG5mE2x2uBucg4eumxJEQsTkFViPwjTevVC9SRL3
 H31yRakzAvXucEo6MjEURa3UehQdmyh11rJ+3LcPwkOdLHRZcC+3Ru6UMWBNNnt0ZUm498qejo
 nErJZx2d3lPn9saquXbhBPFE5u3Bbt7rxd2cWhHsSjcLL+hTLWTKwvA7eOWjGXo2SCj7dFCQe3
 MIiNEH/82LxL4x5HS+AzG9AMfO7vt7jeR5M7tTUg2uoqPu6ewQ9Fh3mT59OMRgV6svjCQ9y0Q5
 +ZBb2vnd5G1n4jAWaM8ldiHu
X-IPAS-Result: =?us-ascii?q?A0BRBQBbQC1i/0Xcza1agQmBWoIoB4FNAQEBKQQLmVmZO?=
 =?us-ascii?q?YF8CwEDAQ1BBAEBiS0CHQYGMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QECAwQBgQgsAWMBZwGBTgGBeQYEPYI1IoQshRSDF648gTOBAYl7gTyGFBRCi?=
 =?us-ascii?q?AUcQIFNgUiCR4YAhTIEm1aSFo97nhODU4ltlWkaLoNhAZJkkXGWV6FDhTiBP?=
 =?us-ascii?q?ykCM4FZHxQaCCYKgyVNAQIBAgEMAQICAQIBAgECAQgBAQIBjXQBMxaOTyABA?=
 =?us-ascii?q?QFpAgYLAQEDCZJlAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:dDGzCqDkLdnUZhVW/zPlw5YqxClBgxIJ4kV8jS/XYbTApGx3gTYFn
 2AcXzrTa/6MYzGmfI8gb4WwoR8Hv5TQztQyOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFw0XqPp8Zj2tQy2YPgWVvX0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYo3aD3O9R7
 PpjjpruQz0uEbSLkskDDjANRkmSPYUekFPGCX2v98GMz0DLd3b2hfNjECnaP6VBpb0xWzkTs
 6ZCcHZTP3hvhMruqF6/YuJrjc8iBM3qJ58E/Hx/zTzUCfs8B5bOX80m4PcIh2hu2pkXdRrYT
 +UjYDZ2ZSngXwUMZgdNDrMEufWOiGaqJlW0r3rO+fRssjeDpOBr65DmN9Hee/SRVMBNlwCZo
 HjH9iL3GHkn2Me3zCrD/22si+LLkDm9Xo8OfFGlyhJ0qB6ZhVMzLDI4bl3lq8O+pVf5Uf9Bd
 mVBr0LCspMO3ECsS9D8WTixr3iFogMQVrJsLgEq1O2e4vGLvFvBVwDoWhYEOYN27pZnLdA//
 gbRx4uBONB5jFGCpZugGlq8qCP0NDcVIGIGaDVCSwYZizUCnG3RpkmfJjqAOPTp5jEQJd0X6
 2nXxBXSf51J0aY2O1yTpDgqQ1uE//AltDId6ATNRX6C5QhkfoOjbIHAwQGFsakZdd3HFwnZ7
 Sdsdy2iAAYmVszleMulG7plIV1Uz6zYblUwf3Yxd3Xey9hd0yX/I9sBv2EWyLZBP9kEdDLtb
 VXSvwgUvMY7AZdZRfQfXm9wYux0pZXd+SPNDamFMIARPsAvKGdqPkhGPCat4owkq2B0+YlXB
 HtRWZzE4a8yBfs1wTyoaf0a1LN3lCkyyXmKFcL/zg+7yvyTe36YRLMIKh2IY/xgtPGIpwDc8
 tB+McqWykwFDLakOnSOrdcefQIQMHw2JZHqsMgJJOSNFQpRBz1zAfHmx758KZdumL5Yl7qW8
 yjlCFNY0lf2mVbONR6ONiJ4cLrqUJsm9SA7MCUgMEyGwX8mZYrzvq4Te4FuLesj9fd/1rh5U
 PkIdsGNGLJJRyieo2YRapz0rYpDchW3hFvUY3H/OGVmI8dtHlWb9MXlcw3j8Dg1IhC27cZu8
 ae90g77QIYYQ1owBsjhaMWwkwG7s08blb8gREDPONRSJRvhqdA4Nyzrg/YrCMgQMhGflCCC3
 gObDBpE9+nAp4g5rIvAiaye9tr7Fvs4E1VaEmTf4KzwMyTGpzLxzYhFWeeOXDbcSGKtovn5P
 70Ilq2lPa1VhktOvqp9D61vk/A06ezvkKAGnA5qK3PGMgawAbR6L3jbg8QW7v9RxqVUsBedU
 16U/oUIIq2APc7oTAwLKAw+YrjR3P0YgGCPv/ElZkjl5CJ6+LedF0NfI0DU2iBaKbJ0NqIjw
 Psg4ZRKsFbn10N2a9vW3DpJ82msL2AbV/t1vJ8tALj01lghxGZEbMGOESTx+pyONotBaxF4P
 j+OiaPerL1A3U6eIWErHH3A0Oc1aU7iY/yWIIvu5mhlm+YpQtcyzFtc7jQ6QwBY1FNB3v4b1
 q2H8aFqDf3mwtuqrJErs6OQ98VpAByC5le3xkQJmWDdQlPuUGHRRIH41SBh42hBm1+xvVFnE
 HWwzGf+TS2scd7x0yY2VFQjrfH/JTC0Gssuh+j/d/m481IGjfYJT0Ngiafka/cqPC/puHD6m
 A==
IronPort-HdrOrdr: A9a23:Mx954axUxKnc4hLPKqUtKrPwPL1zdoMgy1knxilNoH1uA6ilf6
 LHppsmPHDP5gr5NEtApTniAtjkfZq/z+8W3WB5B97LN2SLhILCFvAA0WKN+V3d8vLFnNJg6Q
 ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,177,1643670000"; 
   d="scan'208";a="8376411"
X-MGA-submission: =?us-ascii?q?MDEXb+ipI47GVRpQIH80+59z3VLNCNNo8i+1RJ?=
 =?us-ascii?q?Eqqw4g1aO2kuVBhUUcPCPkql4+xeRhf8nJnhqJxZW0cAwLlNT1eCq3Bj?=
 =?us-ascii?q?wRNcZ2AeBPIMDd6YWmzRK2QomgTerXdvdmQwqTi8zEKEOdllA7BWO74A?=
 =?us-ascii?q?mveWm5aw7iUNAJ/ot6r82JSQ=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 01:53:29 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 3DA7C47
	for <cocci@inria.fr>; Sat, 12 Mar 2022 16:53:26 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id CNuSFe6gxe-H for <cocci@inria.fr>;
	Sat, 12 Mar 2022 16:53:25 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 55F8940
	for <cocci@inria.fr>; Sat, 12 Mar 2022 16:53:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 55F8940
Date: Sat, 12 Mar 2022 16:53:22 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: cocci@inria.fr
Message-ID: <9112994e-3913-54e-dfc1-b1b7f54fc191@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] Can Coccinell concatinate or append to existing string
 literals?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 211
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/9112994e-3913-54e-dfc1-b1b7f54fc191%40ewheeler.net>

Hello,

I would like to do something like this:

	@ a @
	constant C;
	constant CN ## "_bar";
	@@
	-foo(C);
	+foo(CN);

to produce this:

	void f()
	{
	-	foo("foo");
	+	foo("foo_bar");
	}

It looks like `fresh identifier` can do something like this, but I can't 
get it to work with strings.  Is there a way?


--
Eric Wheeler
