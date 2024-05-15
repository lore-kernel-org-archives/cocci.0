Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B26C25B77
	for <cocci@archiver.kernel.org>; Wed, 15 May 2024 09:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=YelJMSSgWlaN2Gs8wM9Bm1BPXGqzlKn98oqjxXIs9lo=;
  b=I59OLOB6Ok51xblcGyFIPzlgzpLjOcF6dvd4/huZWlBia/uzdg1BzVj5
   HCMyMsCdtQCWxqKAyeW9kvboYOQ/iasl31wgGVShlTrU6dGfxQN1v3pHT
   shQF+EHMkODvxrAT/D9w7iN6qrMPoQRHSAKx1fWBA7VPVc7W7/i8BhwST
   o=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; 
   d="scan'208";a="165820736"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 May 2024 11:08:42 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8EFF6E0CCF; Wed, 15 May 2024 11:08:42 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 92DFFE004E
	for <cocci@sympa.inria.fr>; Wed, 15 May 2024 11:08:39 +0200 (CEST)
IronPort-SDR: 66447b97_p/uNNGRk5AHP967aR8gyfnRK1/2HeYt7L3SJbvKoCANxYxm
 cOIPmvslEoo1BsmA8/ll9QwDYs0Mbs+cYk6Av+A==
X-IPAS-Result: =?us-ascii?q?A0FJAgDoekRmkAH/B8NaHgEBCxIMQIFEC4JEfFgzBwhIh?=
 =?us-ascii?q?FaDT44bA54KgX4PAQMBDTUPBAEBAwEDgguCdAKIQAIfBgEEMgcOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEBAQEgHhAOJ4V0DYJgO4IQL?=
 =?us-ascii?q?A18AQEBAgEjFUYLCxoCJgICVhsBAYJ8AYJBIwewVIEygQGDHNsVgWYGgRoui?=
 =?us-ascii?q?C4BijwXEBUGgg2BPAsDgnU+hRCDDoJpBJoWHpBJVH0cA1khAhEBVRMXCz4JF?=
 =?us-ascii?q?gIWAxsUBDAPCQsmKgY2AhIMBgYGWSAWCQQjAwgEA0QDIHERAwQaBAsHdYF2g?=
 =?us-ascii?q?TUEE0eBOIl1DIMvgXUphB5LbBQBg3OBdg5hg1GFLoEUbx1AAgELbT01CQsbK?=
 =?us-ascii?q?AEdo1OCYC2Bb2AxTYEco2OhVIQdjA6VIwYPBC+XOBSSaJhiqQeBbAcsgVxNN?=
 =?us-ascii?q?ASDIk8DGQ+OOoNhxiJCNTsCBwsBAQMJiSKBSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 b4biYdAD6B6F0H/YZcUhu8=
IronPort-HdrOrdr: A9a23:WtVBE6+72Bpw9lwsd/Vuk+DbI+orL9Y04lQ7vn2ZOiYlEfBw8P
 re+sjztCWE7wr5N0tMpTntAtjjfZqYz+8Q3WBzB9uftWvd0ldA/LsSiLcKqgeIc0bDH6xmtZ
 uIGJIRNDSfNzlHZIrBjzWFLw==
X-Talos-CUID: =?us-ascii?q?9a23=3ALg8ZAmnD1NUYaUXhAZvObuBTMsvXOVLDwEr8CHS?=
 =?us-ascii?q?9NWhsYYSXWGDT+P1Aj9U7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Ai09LhA3BhG1ReeEkRFV6QwhkhjUj4/qkUF82z6k?=
 =?us-ascii?q?9l/K0MgFSCwe0qSyJa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; 
   d="scan'208";a="165820720"
X-MGA-submission: =?us-ascii?q?MDFvMwsO0xTITTm+IWhWd3Ly0P8nXlfzQU2zXK?=
 =?us-ascii?q?T5TJQBY6huIy2JrpMnYUGH1fYGhT73OsXzLadYybKxUlmbOZ9swQxJv4?=
 =?us-ascii?q?8jT2vDzKFotrEmc/1eGKPbp73kq0L4KqMa4bwVWGjaMUZQR0ikqGmuh8?=
 =?us-ascii?q?eFYSASvxgGTNGhof5GLHjf0g=3D=3D?=
Received: from mail-out-auth1.hosts.co.uk ([195.7.255.1])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 11:08:38 +0200
Received: from [188.213.138.56] (helo=[192.168.1.186])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <derek@knosof.co.uk>)
	id 1s7Aco-00000000CWH-4yVh
	for cocci@inria.fr;
	Wed, 15 May 2024 10:08:38 +0100
Message-ID: <043e82d3-7299-4aac-abfe-60bd858dc598@knosof.co.uk>
Date: Wed, 15 May 2024 10:08:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <233b3043-2539-42f4-b47a-771b0094b558@knosof.co.uk>
 <alpine.DEB.2.22.394.2405150758100.3404@hadrien>
Content-Language: en-US, en-GB
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
In-Reply-To: <alpine.DEB.2.22.394.2405150758100.3404@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] ChatGPT 4 and Coccinelle
Reply-To: Derek M Jones <derek@knosof.co.uk>
X-Loop: cocci@inria.fr
X-Sequence: 1743
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/043e82d3-7299-4aac-abfe-60bd858dc598%40knosof.co.uk>

Julia,

> I agree.  The whole premise behind Coccinelle is that the intelligence and
> responsability of the human behind the semantic patch will make up for the
> added ability to introduce bad code on a large scale.

LLMs can write bad code without needing to use Coccinelle.

Tool integration allows LLMs to offload stuff that is beyond
their token prediction ability, e.g., how many baseballs fit in
a Jumbo Jet gets fed into Mathematica, or a Python script on
the open source LLMs.

The code tool integration focus at the moment is on SQL.

In the following, Coccinelle may have been picked first because of
my earlier question.

Derek
What is the best tool to use to replace calls to an old version of an API with the equivalent calls in the new API?

ChatGPT 4
When you need to replace calls to an old version of an API with calls to a new version across a large codebase, using an 
automated refactoring tool can be the most efficient way to manage this task. Here are some of the best tools and 
approaches for this purpose:

1.  Coccinelle:
         Coccinelle is a tool designed specifically for performing large-scale source code transformations in C 
programs, though it can be used for other languages with some adaptations. It allows you to write semantic patches (in a 
special language called SmPL) that describe both the code to find and the code to replace it with. This can be 
particularly useful for API updates where changes are systematic.

Refactoring tools in Integrated Development Environments (IDEs):
Rector for PHP:
JSCodeShift for JavaScript:
Custom Scripts:

-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com
