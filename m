Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8B9C433FE
	for <cocci@archiver.kernel.org>; Sun,  9 Oct 2022 15:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=zQz87dfVC3kWInF6RlWxjFeuXeTOKApeEQvjWsCGSdk=;
  b=iIywX6lwXPyhsHD63SiRkeHLWz936+tzSe0CTJMJWVHKCrQ81lYqKbPn
   xRWTGXv0FPMJCmSRTk7L0dbMbm0fHHE3D0/nBgYpGLPercT58yuiro1Jl
   f2udI50IDVjAz4OsWJSOi+8R+MYeilqUkwtgv+fVgt1FfsUHsx7xiihuB
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@zx2c4.com
X-IronPort-AV: E=Sophos;i="5.95,171,1661810400"; 
   d="scan'208";a="56680579"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Oct 2022 17:11:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 939A0E028F; Sun,  9 Oct 2022 17:11:23 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8BDAEE0121
	for <cocci@sympa.inria.fr>; Sun,  9 Oct 2022 17:03:47 +0200 (CEST)
IronPort-SDR: 6342e2d3_Bm9Jppmul16srAXkuzQOcseIFTxOQZIhBY7AoraA39ERM3B
 ruDGRWqmJnWYREJjMhURSmsvujB4nJwWfMqKvaw==
X-IPAS-Result: =?us-ascii?q?A0DrBAB44kJjfTdJKJFaHgE8DAILFYNzgVcuBAtFhE6If?=
 =?us-ascii?q?oVygiWfHwEDAQ1CBAEBiXsCHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBA?=
 =?us-ascii?q?QECAQECBAQBEwEBGgk8BSKFaA2CNSKEFQQZAQE3ATQCJgIShn4GAat6fzOBA?=
 =?us-ascii?q?YIIAQEGgmCEDH4JgREsi3ODQ4EhgimBFYwDgmaaNDgDRB1AAwtCNhgDFAMFI?=
 =?us-ascii?q?QcDGQ8jDQ0EHQwDAwUlAwICGwcCAgMCBhMFAgJNNAgECAQrJA8FAgcvBQQvA?=
 =?us-ascii?q?h4EBQYRCAIWAgYEBAQEFQIQCAIIJhcHEzMZAQVZDgkhHCgNBQYTAyBvBUIPK?=
 =?us-ascii?q?C9pKx0bB4EMKigVAwQEAwIGEwMgAg0pMRQEKRIPLQcpcQkCAyJqAwMEKCwDC?=
 =?us-ascii?q?SEfBygkPAdYOgUDAhAiPQYDCQMCJFmBKCYFAw0ZJggFNxoECDwCBQZTEwIKE?=
 =?us-ascii?q?gMSDy1JD0o+PZtWPAZ8JwiCL1aSKZBWnmgHA4Neg0qccjKWaJIelxCnb4F4I?=
 =?us-ascii?q?y2BLnCDN04cD44sFoNQin0iNDsCBgsBAQMJixUBAQ?=
IronPort-PHdr: A9a23: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
 jAuvLnyLnFZ9M/O9sZaBMXOLs+Ddn07PkixcAM=
IronPort-Data: A9a23:a0/l+66leO9yRGFbWMeOrwxRtCrDchMFZxGqfqrLsTDasY5as4F+v
 mMZUD+CMv+IYzGgKtBxao7n80JX6sfRzYJiGVZo+S0zZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOC6UIYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE0
 T/Ii5S31GSNhnglbwr414rZ8Ek15ayq6WtB1rADTakjUGH2xyF94K03fvnZw0vQGuF8AuO8T
 uDf+7C1lkuxE8AFV7tJOp6iGqE7aua60Tqm0hK6aID+6vR2nRHe545gXBYqhei7vB3S9zx54
 I0lWZVd0m7FNIWU8AgWe0Ew/y2TocSq9ZefSUVTv/B/wGXdVEW3zNpoHX0vAoNBpON9C3Bz+
 eAHfWVlghCr34pawZqgS+8qncM+NsLmeoASoHdtyXfeF/lOrZLrGvmXo4MAmmhrwJ0TdRrdT
 5JxhT5HVy77O0hGM3oIXcgdyfW43HKjNTZfrQe3rLEw5UDQwRZ33byrN8DaEjCPbZgLwBbA/
 jufl4j/KhwaJvG2lzq7yFyphOCRuyTHA4tREpTto5aGh3XInzdLVUVOPbehmtGyjUW1WvpEO
 kkM82wvq7Iz/QqlVLHAswaQu3+C+AUbRsBbHqs55RuLx66S5ByWboQZctJfQMcBipQ5ajo76
 ka2kYq3ADZloYCZVW3Io994sgiOESQSKGYDYwoNQg0E/8TvrekPs/7fcjpwOPfv34Cqcd3k6
 2nS93hm3el7Ydsjjf3TwLzRv967jqPmJuLfzjzKU2+j9R9+e4jtSpe04ETWhRqrBN/FJmRtU
 VAfms7Y9+cTF5qA0i+AWuMAGPeu/fnt3NzgbbxHQchJG9eFoSXLkWVsDNdWfx8B3iEsIm+BX
 aMrkVkNjKK/xVPzBUONX6q/Ct4x0Y/rHsn/W/bfY7JmO8YvKVXap3EyNRTKhwgBdXTAd4liY
 f93lu7xUB4n5VhPlVJaus9DjOB6nEjSO0uKFc6TI+ubPUq2PyfOEepdaDNin8gh5aiHrRmd8
 9FEK6O3J+Z3DYXDjt3s2dNNcTgicCZqbbio8JY/XrDYfWJb9JQJUaK5LUUJJ9c4xcy4V47go
 hmAZ6Ov4Aqk2SSceV7XNBiOqtrHBP5CkJ7yBgR0VX7A5pTpSd/HAH43J8VpL4o0vvdu1+B1R
 PQjcsCNSKYHADfe9jhXKdG3oIV+fV75zUiDLgi0UggZJpRAfg3u/sO7Xw3N8CJVMDG7m/Fjq
 JKd1yTaY6E5eSJcMOjsZsiSkmyB5UompLoqXm/jAMViR0H3wY07dw3zlqAWJu8PGzXixxyb9
 RykMTUFl9bSvoVu0t/ohL+FnaitAeBRDkpXJEiFzLeUZA3x3Huv/p9Ea8mMJQvibWLT/L6zQ
 9lVw9XXEuw1rHwTv6VSS79UnL8Dvf3xrLpk/yFYNXTsbWXzLIh/I3ODjPJ9hocUypB34QKJC
 1+yoP9EMrC0OeTgIl4bBCwhSs+hjfg0uD3j3c4ZEXXAxh1c3eS4CB1JHhy2liZiAqN/M9olz
 ccfqccm0VGDpSRwAOmWrBJ/1jqqHiQbXrQFp6MqJtbhqjAWx2FoZb3eDS7L46+zVehcD3lyI
 hKpgPvturcN4GvDbHs5KlbV18V/m5klmU5H3X0CFXuzi/vHgf462hJAwCYOUzUPnwlm0v1yC
 EdvJUZaNaWDxBY2pclhDkSHORBNOw2dwWP1k2A2rWz+S1WkckfvPV8NE7+B025B+l0NYwUB2
 q+TzVjUdArDfebz73MUYlFkofmydu5B3FTOt+7/FvvUAqRgRyTuh5KvQm86qxHHJ8cVr2+fr
 MlI+NdAU4HKBRQykYYaVbbDja8xTSqaLlNsWftipaMFPV/NcQGIhAShFRqDRdNvFdfrr2mIU
 9djN+BeZSSYjSyulA0WNYQIAr1zncMq2uY8R6PWFTYGnYey/jtNm7DMxxf6n14uEolPk95iC
 4b/dACiM223hFlGklCRscIeazOzZP8AQAjg2OuwreEDPM8du+RncGUZ8Li9j1OKOiRJojOWu
 wLiYffN7upAkI5DoarlIp9hNS6Vd+zhdb2v3lioktJsadjvD5//hzkNoAO6AzUMbKojZdtns
 J+s7vj15Rrhl5QrWTn7n5KhKfF41f+qVrAKDvOtfWhopgrcasrC+BBZxnuZL6ZOm9Zj5sWKY
 Qu0Rc+zVNwNUedm23xnRHlCIikZFpjIQP/slQGlo9SILyot4wjNAdek1H3uNG9lL35Cf9W0D
 wLvoP+h6+xJtIkGVldOG/hiBIQ+O1P5H7cvc9rqrzSDE220mRW4t6D/kQY7oyT+YpVe/B0WP
 bqeLvQ/SPizhE0M5MpYtcppuQANB3s7guQqeE8ZvdlshFhWyYLAwfs1af075lN8y0QeF60Uo
 BnOYXEkBCG7Wi5LGfk5yMq2RR+RX4TiJf+gTgHEPCqoh+OeFpPaC+cn/SBli5uzlv0P08n/Q
 ewjFrbM0tRdD32nqSv/JhB2vAu/+s7n+w==
IronPort-HdrOrdr: A9a23:jJ/UwqmqPygq842y4cH7NXf9ETnpDfIn3DAbv31ZSRFFG/Fw9/
 rCoB3U726WtN80YgBHpTngAtjmfZq4z/JICOYqU4tKMDOGhILKFvAH0WKB+UyEJ8SWzIc0vs
 0OT0EUMqyTMbEVt6bH3DU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,171,1661810400"; 
   d="scan'208";a="56680011"
X-MGA-submission: =?us-ascii?q?MDE8FxGHzGFWICiml98gTJOmMMnTzNr5qscyN+?=
 =?us-ascii?q?5s5vQdJxm05nafVznVPlLVSA+3BISxf8ir6AWW4Jao4q3jHKBD6oE+Kq?=
 =?us-ascii?q?umjsXhqwKwwtcQZNy0h/Qgfhs3l+InqYqEidXj+Mb9pdobEtc9ZE0k86?=
 =?us-ascii?q?SYWpgHrq+HmpOUrNViThIbWw=3D=3D?=
Received: from sin.source.kernel.org ([145.40.73.55])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 17:03:46 +0200
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id C9CA6CE0A23;
	Sun,  9 Oct 2022 15:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81842C433C1;
	Sun,  9 Oct 2022 15:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1665327818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=zQz87dfVC3kWInF6RlWxjFeuXeTOKApeEQvjWsCGSdk=;
	b=WJKfDxCOvZi3vaqYN1SjfwXIjdoNKtLyHX0dZ3cNzOkE0mIAM5YPKDjrEBfMV2lDp8SFL+
	NX4Uhg+q9IbVlSXf9zmBHirF3fzd+lLtfzejJ6KwCAbqEVTVwMBJa2JQJeVOg+jMbZr/u9
	kmDJPsdWmVXqBfdWLAk5mgNDLZnAYlQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c3d1a847 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 9 Oct 2022 15:03:37 +0000 (UTC)
Date: Sun, 9 Oct 2022 09:03:36 -0600
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: cocci@inria.fr
Cc: keescook@chromium.org
Message-ID: <Y0LiyBxZ0pU+NOPR@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] "reachable by inconsistent control-flow paths"
Reply-To: "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Loop: cocci@inria.fr
X-Sequence: 624
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/Y0LiyBxZ0pU%2BNOPR%40zx2c4.com>

Hi,

I've got a fairly simple rule that works on easy contrived examples:

@@
identifier get_random_u32 =~ "get_random_int|prandom_u32|get_random_u32";
typedef u16;
identifier v;
@@
   u16 v;
   ... when exists
-  v = get_random_u32();
+  v = get_random_u16();

However, when I try to apply it to a real function, afixed below, I get
the error:

    rule starting on line 1: node 172: off = ... ;[1,2,67,68,70] in nf_nat_l4proto_unique_tuple reachable by inconsistent control-flow paths

I tried using the option "--allow-inconsistent-paths", and it works, but
that also seems potentially scary. I figure if it's not on by default,
it must be for a good reason. Any idea what's up here?

Thanks,
Jason

---------------------------------------------------------------------

static void nf_nat_l4proto_unique_tuple(struct nf_conntrack_tuple *tuple,
					const struct nf_nat_range2 *range,
					enum nf_nat_manip_type maniptype,
					const struct nf_conn *ct)
{
	unsigned int range_size, min, max, i, attempts;
	__be16 *keyptr;
	u16 off;
	static const unsigned int max_attempts = 128;

	switch (tuple->dst.protonum) {
	case IPPROTO_ICMP:
	case IPPROTO_ICMPV6:
		/* id is same for either direction... */
		keyptr = &tuple->src.u.icmp.id;
		if (!(range->flags & NF_NAT_RANGE_PROTO_SPECIFIED)) {
			min = 0;
			range_size = 65536;
		} else {
			min = ntohs(range->min_proto.icmp.id);
			range_size = ntohs(range->max_proto.icmp.id) -
				     ntohs(range->min_proto.icmp.id) + 1;
		}
		goto find_free_id;
#if IS_ENABLED(CONFIG_NF_CT_PROTO_GRE)
	case IPPROTO_GRE:
		/* If there is no master conntrack we are not PPTP,
		   do not change tuples */
		if (!ct->master)
			return;

		if (maniptype == NF_NAT_MANIP_SRC)
			keyptr = &tuple->src.u.gre.key;
		else
			keyptr = &tuple->dst.u.gre.key;

		if (!(range->flags & NF_NAT_RANGE_PROTO_SPECIFIED)) {
			min = 1;
			range_size = 65535;
		} else {
			min = ntohs(range->min_proto.gre.key);
			range_size = ntohs(range->max_proto.gre.key) - min + 1;
		}
		goto find_free_id;
#endif
	case IPPROTO_UDP:
	case IPPROTO_UDPLITE:
	case IPPROTO_TCP:
	case IPPROTO_SCTP:
	case IPPROTO_DCCP:
		if (maniptype == NF_NAT_MANIP_SRC)
			keyptr = &tuple->src.u.all;
		else
			keyptr = &tuple->dst.u.all;

		break;
	default:
		return;
	}

	/* If no range specified... */
	if (!(range->flags & NF_NAT_RANGE_PROTO_SPECIFIED)) {
		/* If it's dst rewrite, can't change port */
		if (maniptype == NF_NAT_MANIP_DST)
			return;

		if (ntohs(*keyptr) < 1024) {
			/* Loose convention: >> 512 is credential passing */
			if (ntohs(*keyptr) < 512) {
				min = 1;
				range_size = 511 - min + 1;
			} else {
				min = 600;
				range_size = 1023 - min + 1;
			}
		} else {
			min = 1024;
			range_size = 65535 - 1024 + 1;
		}
	} else {
		min = ntohs(range->min_proto.all);
		max = ntohs(range->max_proto.all);
		if (unlikely(max < min))
			swap(max, min);
		range_size = max - min + 1;
	}

find_free_id:
	if (range->flags & NF_NAT_RANGE_PROTO_OFFSET)
		off = (ntohs(*keyptr) - ntohs(range->base_proto.all));
	else
		off = prandom_u32();

	attempts = range_size;
	if (attempts > max_attempts)
		attempts = max_attempts;

	/* We are in softirq; doing a search of the entire range risks
	 * soft lockup when all tuples are already used.
	 *
	 * If we can't find any free port from first offset, pick a new
	 * one and try again, with ever smaller search window.
	 */
another_round:
	for (i = 0; i < attempts; i++, off++) {
		*keyptr = htons(min + off % range_size);
		if (!nf_nat_used_tuple(tuple, ct))
			return;
	}

	if (attempts >= range_size || attempts < 16)
		return;
	attempts /= 2;
	off = prandom_u32();
	goto another_round;
}
