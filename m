Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B80C02198
	for <cocci@archiver.kernel.org>; Mon, 10 Feb 2025 17:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:sender:subject:reply-to:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=rO0JRWBaYP8RPL9Khbv4P0/RCh3JELHU5FgN/G1z4Ok=;
  b=JFp0bkoGMgNA/Z2d8fshWEqQg2+60jnswBax/N93Yg/j4JsBXau2xczD
   H9NjDrYW8bzhY/Na3IM9jTaLsDSDafAzgYFp0P9nBGYfJZBcfK5OOJmHu
   mpeq1hJm+M/xORqYUxNjIf34TAKbSC3wvmTMVYeyueKPAGWCqd3l3ub5Y
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.org.uk
X-IronPort-AV: E=Sophos;i="6.13,275,1732575600"; 
   d="scan'208";a="207548118"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 18:00:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ADF5AE0D20; Mon, 10 Feb 2025 18:00:22 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A4046E0260
	for <cocci@sympa.inria.fr>; Mon, 10 Feb 2025 18:00:20 +0100 (CET)
IronPort-SDR: 67aa30a4_atXh5/mtD4yVC2v6hT+QiBXD5Px9G3IR9dk4kfms20SLQsy
 BgCc371moMiYL2J8zuf30S++g7Ag8+9HvhjvFDw==
X-IPAS-Result: =?us-ascii?q?A0EbAQCXL6pncq2NWT5aHQEBAQEJARIBBQUBQIFCBQELA?=
 =?us-ascii?q?YJDgVY0BAtIlCWCJKAhAQMBDUEBAgQBAQMBA5AGAh4GBjMGDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMhXsNgmIBM4IWLA1+AQQBOgYBA?=
 =?us-ascii?q?TcBBAsBCjQSVgaFVyMHsQiBNIEBggwBAQbeBQmBSAGITgGFa4R3JxuCDYQOM?=
 =?us-ascii?q?T6IWIIvhCGDQKQEUnscA1ksAUsKExcLBwU5cEgDgREjD4EUBTQKNzqCDWlJO?=
 =?us-ascii?q?gINAjWCCxNdH4IrgiCCO4RDgzWBFoFng3GCEoFgAwMWE4MheByETx1AAwttP?=
 =?us-ascii?q?TcUGwafdZsygy2wAoQlhG+cV00Tg10BpmGYfKkugX0kgVxNNASDIk8DGQ+OI?=
 =?us-ascii?q?TiLO7xfRjI8AgcLAQEDCYVGAQGLGYFLAQE?=
IronPort-PHdr: A9a23:OT7KuxLPcP3iWQxPcNmcuK9tWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCEv7M11BSSDdiKo7Ic0qyK6PmmATRBqb+681k8M7V0FCU5wf0MmAIhBMPXQWbaF9XNKxIAI
 cJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQka3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+N
 hq7oAvPusUMnYduNqk9xxXKr3ZIf+ld2GdkKU6Okxrm6cq98oNv/z5Mt/498sJLTLn3cbk/Q
 bFEAzsqNHw46tfsuRffUwWE+2ESUn8RkhpGAgjF6A/1U5LsuSbkteRzxTeXM9TuQb87RTqt4
 aFrSAT1iCgcLD427HvXis1rg61Fph+qugFyzJTVYIGRM/p+Y7/dcNYHTmdPQspdSypMCZ6nY
 oARE+QOI/pXr4jlp1sPsxS+AxWsBPjywTNMn3P6wLE23/gkHQzAwQcuHc8BsG7Modv7NKkcT
 /64wrTLwzXNYPxZxSry54rTch06vfGAQah9fdbNxUUzCQ/IiEibp4z/PzOS0+QAq3SW7+59X
 u2gim4nsQZxqSWoy8cyi4nJnIUVx0vF9CpnxoY1JMO4RFR/Yd6lFptQqi6bO5FxQsM4TGFko
 js6yr4ftJO9YSMFx4gpyQTFZPybb4iH/AjjVOCJLDpmmn9pZbCyihi8/0agxOPxUtS43EpKo
 yZbjNXCtnIA2wLc58WJVvZw8Ems1DSL2g7d6+xJPUE5mKrYJpM8w7M9kIcYv0fbHiLumUj6k
 rWae0Yg9+Sy9ujqbajqqoWBO4J2hAzzNLkll9K7AeQlKQgOQ3aU+f6h2r3i/Ez2Xq1HguEwn
 6LEqp7VP94bqbS8AwJN0oYs9RK/DzC+3dUZg3YHKlNFeAydg4jtOlHOJu34DPilj1Srijdry
 OrKPqDiApnVL3jDlqnufapl5kNd1gY/19NS6pZOBr0cL///R1X9uMHaAxI3KwC0xvzoCNR51
 oMQQ2KPBaqZPbvMsV+J/OIvJPKBZIEJuDblMfQl4//ujXkkmV4SZ6Wp2oEXaH+iEvR7IEWVe
 XzsjcwZHmcQogU+VPDqiEGFUTNLenq+R7g86S0jCIK6EYfDQZigj6CG3CinApJWZ3tLCkuME
 Hftb4WLQe0AaCOUIs97kzwLT6KtS4E71ULmiAiv8KZqMOfSshcfro7u2MQ9s/fUjg0/+SBcA
 MOa32SMVCdzhGxeFBEs26UqiEg19FaZ1uAsnf1CEvRB6vVITEE+NJjB36p9Ed+0RwGXLYTBc
 0qvXtjzWWJ5ddk22dJbJh8lQ71K7zjG1iuuWfoOkqCTQYYz+eTa1mTwIMB0zzDH0rMghh8oW
 JgHLnWo04h48QWbHIvViwOBja//a6UG2wbD6H/FyWuIoVEeVxR/F7jGDjgEfkWDi9P/6wvZS
 qO2T7EuMw9P08mHf7VLcNrBg0leAvPiPsnOJWWrlCGtBkXA3auCOaztfWhVxyDBEA4EngQUq
 G6BLhQ7Dzy9rnj2HjFoFEypZ0Lq7Pk4r2m0CFI3p+2TR2tm0bf9uhschPjGDugWwqpBoiAq7
 TN9AFe62dvSTduGvQtoOqtGM5s75x9c2GTVuhYYXNToJr1+hlMYbwV8vl//nxRxBIJalME2r
 XQshANsIKOc2VlFenuWx5f1crHQL2Dz+lioZcu0khnA0cyR0qkT8LI8qlP+rEeuDEVk7nYmm
 9hZ3n2A54nbWRIIWMG5WUI2+h5m4rDCN3dnodOFkyQwaO/t7WSRvrBhTPEowRuhYdpFZaaNF
 QuoVtYfG9DrMush3V6gchMDOulWsq8yJcKvMfWci8vJdK5tmiyriWNf7cVzyEWJomBiS/TP9
 5gZ27ec3w2aR3H7lljnr8O9yuUmLXkCW3GyzyTpHtsbeKxoeq4FFX/oJ8yx28U4gITiHWNbv
 g3GZRtOyIqifhycaEb41Atb2BEMoHCpriC/yiR9jzAjqqf3MDXm5ePkeVJHP2dKQDMnllLwO
 c2uiNtcWkG0bg8vnR/j5EDgxqEdqr4tZ2/UCVxFeST7NQQAGuO5q6aCbshT6ZgprTQfUeKyZ
 kqfQ6L8pB1S2j3qHm9XzjQ2Pz+wvZCxkxt/gWObZHF9yRiRMd9x3xD36sDEA/pQ2CcWAi5ih
 n/KBRn0PtWk+8mVi4aWt+m/U2y7UZgAFEujhYiEtSa9+ShrGUjhxbbjy5u+TVF8iHCghLwIH
 W3SoR3xY5fmzfG/OONjJAxzAUPkrtB9Ecd4m5cxg5cZ3T4bgI+U9DwJizSWU50T1KTgYX4KX
 TNOzcTS5V2vxkx5KVqH25q/UnSb39snYMO1JH4VkHFYjYgCGOKP4bpIkDEg6ES5twX5b+Rl2
 DMcz+Y+rnkAjKcUu0B+q0fVSqBXFk5eMyv2kh2O5N3rt6RbalGkdr2o3VZ/l9SsZF2biidbX
 nuxOpIrHCsqq956LEqJynr4rIftZNjXa9sX8BySiRbJyeZPeto3kbIRiCxrNHiY3zVtwvMnj
 RFowZCxvZSWY2Rr8qWjBxdENzrzL8oN8zDphKxak46YxYeqVplmHzwKWtPvQ5fKWHoKsu/7M
 g+VDDAmgmWWH7vBWwue7lp26XXVHNa2NDDfJXUUy8ljWAjIJEFbh1NxPn1ylZo4Gwa2gc35J
 RkjoGBAoAek810Vlbk7Unu3Gn3SrwqpdDouHZ2WLR4MqxpH+1+QK8uVqOR6AyBf+JSl6g2LM
 G2SIQpSXgRrEgSJAU7uOr626JzO6e+dU6CgLuHJSbuSsapaVvGV1dSoyIQg4jXGZaDtdjFyS
 uY23EZORyUzA8PChzAGUDAajQrfYsiaulG4+ytqvoa46vutRQGltu7tQ/NCdN5o/R6xm6KKM
 eWd0T14JThv3ZQJ3XbUybIb0Tb6bglgayHrFbUGqD6LS7jf3LJUXUZzg8xbOtdQqaY92BRdf
 8nBhZXo1ewg5hbUI0VIU13/3MWoY9EaZWanOxXaBxTTXIk=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:9KpY1ag51uWYFX500mz0uIdz/XBQXssji2hC6mlwRA09TyX4ra
 2TdZsguyMc5Ax6ZJhko6HiBED/ewK/yXcF2+Us1N6ZNWGMhILrFuBfBODZrAEIdRefygck79
 YET5RD
X-Talos-CUID: =?us-ascii?q?9a23=3ArtUucGiz5zxcJGdPO/b05TOiQTJua2eMkUaXIH6?=
 =?us-ascii?q?DUm90ev6KZw6y+KUnqp87?=
X-Talos-MUID: 9a23:pMtn4gYKiU3ZouBT6ATujg9JFZpU5qGwDh0AvKUttMqtOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,275,1732575600"; 
   d="scan'208";a="207548101"
X-MGA-submission: =?us-ascii?q?MDFj/ZbA22X21EZeyG1V4u1TU3fAzgjycheD3f?=
 =?us-ascii?q?12iCIvotEjeUt/KhA6CpD8x2DocOt3c9anZKB7EiBd4r9odb9RWRvWdi?=
 =?us-ascii?q?pfhhbN0usS4QvEU7RmZpNENPznqwNWDDqiZATYyW2tKwnjazaXAj1ljB?=
 =?us-ascii?q?Bh4H3pT6QKXrpVMyjv0jc0Pw=3D=3D?=
Received: from zeniv.linux.org.uk ([62.89.141.173])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 18:00:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rO0JRWBaYP8RPL9Khbv4P0/RCh3JELHU5FgN/G1z4Ok=; b=AVUHrXPIUB1PM4gwbWgTcDQsV/
	Yd9eVqQbskGtBdI5sSpP9iDV0cvNwVETw/P5AZ6icYqsiMBRXtYp3cU+jDvCNglUJTE9PYHb3IA0O
	PZAPrZvY1waDH4eEjxoI4v1ILyywpqEUCj3tw7XoNW1mkl/O0JK9woFMHuUJim0b98EbBuEEFq/Sb
	ZYorX5A6ptUrBJ7NALsqXHMgZACXTV9jD8wcrgmudNzOT79hI8TVffHrMInjOIWHIXlr2ZdYt6Ppp
	o8o4kqknj5nfb4nyIdYkCDcwo9Ew4x8PJaraMz3K7zypYtziWbdLkq8QPen8UzkpFBmoTX6OOvb2k
	vEBqtdgw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thX8q-00000009dX9-1QaO;
	Mon, 10 Feb 2025 17:00:16 +0000
Date: Mon, 10 Feb 2025 17:00:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: David Reaver <me@davidreaver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, cocci@inria.fr,
	linux-kernel@vger.kernel.org
Message-ID: <20250210170016.GD1977892@ZenIV>
References: <20250210052039.144513-1-me@davidreaver.com>
 <2025021048-thieving-failing-7831@gregkh>
 <86ldud3hqe.fsf@davidreaver.com>
 <20250210115313.69299472@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210115313.69299472@gandalf.local.home>
Sender: cocci-request@inria.fr
Subject: Re: [cocci] [RFC PATCH 0/6] debugfs: Replace dentry with an opaque
 handle in debugfs API
Reply-To: Al Viro <viro@zeniv.linux.org.uk>
X-Loop: cocci@inria.fr
X-Sequence: 2401
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250210170016.GD1977892%40ZenIV>

On Mon, Feb 10, 2025 at 11:53:13AM -0500, Steven Rostedt wrote:

> No it will not be fine. You should not be using dentry at all. I thought
> this was going to convert debugfs over to kernfs. The debugfs_node should
> be using kernfs and completely eliminate the use of dentry.

I disagree, actually - kernfs is an awful model for anything, sysfs included...
