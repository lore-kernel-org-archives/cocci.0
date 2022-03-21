Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E02C433EF
	for <cocci@archiver.kernel.org>; Mon, 21 Mar 2022 17:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BI9Y/9EIhTYWd+vZRIa5k9Fwv+MGAwKhLxXM0MR9IVA=;
  b=QkxhN9s4n6JRQptNxxC/LDpF44PK8vSLQpM9MXx3oX2ugpzgrDx54WQ5
   2aXEhCkapz+fklWQWeKT6Yoadxed6PaxkF8Sitrqez2sgGz7P557EchLn
   Ar6HsvOLm1Z9cL5+Cnn8Dnl1aL5EjSgPEFNVdpD0oYnrXZhrT54V/VAch
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
X-IronPort-AV: E=Sophos;i="5.90,199,1643670000"; 
   d="scan'208";a="27300588"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2022 18:46:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 67AB1E0219; Mon, 21 Mar 2022 18:46:35 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6A784E0069
	for <cocci@sympa.inria.fr>; Mon, 21 Mar 2022 18:46:33 +0100 (CET)
IronPort-SDR: wcv29CObBMtp1fj2CgvDq9G8nNzC4oqzYaAUKPYr/mmuJH324Vh3fLbWsi9TO72kG89r/+HskE
 oChLQSff94bqFDdupx3oBeLoQBu/QjsDHPp8lCH/JO7J3qSUUBEaq5wOo574HHVHcaikWMr6rd
 0ZKL9vaGYg53VlN3uOhh8oWGM+tcu0SWZYzb1SOKAh59j70BEPkWz1r/H9w/LGACV5XWw49C5g
 PEbx//qBt/d7Hft4nwpUW3MFrkXAxsqetYH/cEAEBWVRlnoYg5Pi/MMTx223+9d+jEKtcryWYb
 WhUrj9kr49IjW4TbxaXfVW/4
X-IPAS-Result: =?us-ascii?q?A0BFBwCNuThi/0Xcza1agQmEAgeBTQEBASkEC5QLhU55m?=
 =?us-ascii?q?kALAQMBDUEEAQGEfYRIAh0GBjQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QECBAQBVjIsAWMBZwGBTgGBeQYEPYI1IoQshRSDF61TgTOBAYl7gTyGFBRCi?=
 =?us-ascii?q?AYcQIFNgTyCU4YAhTIEmR98lC4Rj36eFoNTBYltlWwGFC6DYgGSZpF1lluhS?=
 =?us-ascii?q?oU4gT85JYFZHxQaCCYKgyVNAQIBAgEMAQICAQIBAgECAQgBAQIBjXQBjxchA?=
 =?us-ascii?q?QEBaQIGCwEBAwmRcgEB?=
IronPort-PHdr: A9a23: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
 uFpgiKrslh9Gt/FgHMCVCwamibAdYidqQvuokVK
IronPort-Data: A9a23:54AauKx4Gq00Pcf5AhR6t+cFwCrEfRIJ4+MujC+fZmUNrF6WrkVUm
 DNNUD/QbP+Da2SkKtt2Pt+0/EMB75PTydEyGVM6rFhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefQAOOU5NfsYkidfyc9IMsaoU8lyrZRbrJA24DjWVvW4
 4qq+aUzBXf8s9JKGjJMg068gEg31BjCkGtwUosWOJinFHeH/5UkJMp3yZOZdxMUcaEIdgKOf
 Nsv+Znilo/vE7jBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPgv7
 N4UssG3TD0XHbTpxLQ0bzoCNi5XaPguFL/veRBTsOSW3wvLbHvhzvFjFgcwMJFwFuRfWD4Vs
 6ZAdXZXNEjF2bPeLLGTEoGAguwoK8LgPasbu2p81nfUEvYrTJTOWePM6MMwMDIY3J8VRa6DO
 JVxhTxHSxPfRzteH3wtJMgxpb/w1lfUfSACpwfAzUYwyzOPklcgj+iF3MDuUteNTs5Utl2Jo
 3rPuWX/GBATctKFoQdp6VqplqnCgiP2VYYfDvu+++ICbECvKnI7VjkdDFzmpvyDtG2nfo4PA
 nA3oA8hhP1nnKC0deXVUxq9qX+CmxcTXdtMDuE3gD2wJrroDxWxXTdbE2YQADAynIpnGmxwj
 w7hc8bBXGQ36NWopWShGqB4RA5e1AAQPSkPei8JQA8I+Z/lrZ1bYvPzojRLTPfdYj7dQ22YL
 9W2QM4W3eh7YSkjjvrTwLw/q2jwzqUltyZsjugXN0r8hu+DWKarZpaz9X/Q5utaIYCSQzGp5
 SZYxJjGvb5WV8vUyERhpdnh+pnzt55p1xWH3DZS82QJrWnzk5JdVd84DM5CyLdBaZpaIm62M
 Cc/SCtc+59eMX+nd65xaMfpUqwXIVvITrzYugTvRoMWOPBMmPmvo3k2PSZ9HgnFziARrE3IE
 czCIJj2UipCV/gPIfjfb7517ILHDxsWnQv7La0XBTz9uVZHTHLKG7oDLnWUaeU1sPGNrAnPq
 oYNM8qR1w4ZXfL+byTT/JRVK10WdCBpCZfzos1RV+iCPgs/Qj16UaeMmO94dtw3hblRm8fJ4
 mq5BB1Sxm3/smKbew+EXXZuNeH0VpFloHNmYyF1ZQS022IuaJqE5bsEc8dlZqEu8eFulKYmT
 /QMd8iaLO5ITzDLp2YUYZXn9dwwcBWwmRnIMjWlbTU7coQmQQHVo4e2cgzq/SgILyy2qcpn+
 eH7jFuGGMZaSl07XsjMaf+pw1eghlQnmbp/DxnSP91eWETw64w0eSb/uf8APJ1eIxv0wDbHh
 R2dBg0VpLSTrtZtosXJn62Ns6ygD/B6QhhBB2De4Lu7aXva826kzdMSWeqEZ2mABmbkvqi9Z
 ehYy/zmdvsKgA8S4YZ7Fr9qy4M45sfu/uUGlV48QSyXNln7WKl9JnSm3NVUsvMfzLFuuTypB
 hCF9O5cNOjbI8jiClMQeVQoN7zRyfEOlzDOxv0pO0GmtjRv9b+KXBkAJRWKkyABfrJ5PJl8n
 LUkqIgb9Ayyhx4nKJCAgzwNrzaAKXkJUqMGsJAGAdax1lFxkgwbPcXRWn3s/ZWCS9RQKU10c
 DWas6r1mOgOzET1dXduR2PG2vBQhMlQtUkSnkMCPVmAhvHMmuQzgE9K6T0yQwlYpvmdPzmf5
 oS/24xJyaSyE/NAgdgFUn+sFgxFCQff/EHto7fMeKs1UGHwPlEh7kVkUQpOwKzd22ZdZSRAu
 ryHyGvoVTvwOsf8wkPenKKjR+PLFbRMG86rpCxjN8CEBIUhJzf6gqKjYWcS7R3qHavdQaEBS
 fZCpI5NVEEwCcLcT2DXxWVXOXT8hS1o/FB/fMw=
IronPort-HdrOrdr: A9a23:WkiPiahUp+j6iNGC2VTHcp4yUnBQXsoji2hC6mlwRA09TyX4rb
 HLoBx4vSWatN9/Yh8dcLy7WZVoIkmskKKdg7NhX4tKNTOO0ADEQL2KhrGSoAEIdRefygeD78
 1dT5Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,199,1643670000"; 
   d="scan'208";a="27300577"
X-MGA-submission: =?us-ascii?q?MDFMIp+vMLHB/ZCeQgSGec/Lw/1ZD1Jdoogpnh?=
 =?us-ascii?q?cGWj21dFdhcAXDIXF8eovEk5v/0F3SrJkG88Hd01a3hwQd1Q2ljIKSb/?=
 =?us-ascii?q?9a/mu0f8xYypiM412oILjplUMIE97MSxGc0R4FYlJC9SQrt49Uk0Z2jt?=
 =?us-ascii?q?S7e7fzx9JC8EBgXhuJkl4Bbg=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 18:46:32 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 2375446
	for <cocci@inria.fr>; Mon, 21 Mar 2022 10:46:30 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Odxir3XFvld8 for <cocci@inria.fr>;
	Mon, 21 Mar 2022 10:46:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 5AE0941
	for <cocci@inria.fr>; Mon, 21 Mar 2022 10:46:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 5AE0941
Date: Mon, 21 Mar 2022 10:46:27 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: cocci@inria.fr
Message-ID: <ac59aaae-6e1d-a5e6-e568-2049dc961f93@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] How does Coccinelle call a script language from OCaml?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 274
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/ac59aaae-6e1d-a5e6-e568-2049dc961f93%40ewheeler.net>

Hello,

I'm curious how easy it would be to add Perl, since that is my most 
comfortable scripting language.

Does Coccinelle dynamic-link directly to the python interpreter or 
is piping through |python ?

What source file(s) handle the script invocation?

--
Eric Wheeler
