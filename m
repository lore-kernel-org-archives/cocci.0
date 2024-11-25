Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20024D58D6D
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 16:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3x1bzzmFUBahC3TfHepHEPzbwdyBIgkYtbBAIonr9rE=;
  b=Y1XTxb8ZrRHoWz0dQBur7q/6iQ3DQqAIc3SWyxuCamtgG+0QQd23tvEi
   eriBaV5tZNGF60iLEXp7Xl3VFzl2/b9oCSoJuC4Lo/rTM7ZEEaUNtetnv
   /bIkHzTzp0wXIm+YwLAZrwuadgcJwuXeRZ5mtSgQH1Lq1yff0UYAevzjh
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195724811"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 17:57:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BA5C5E0DE6; Mon, 25 Nov 2024 17:57:26 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 53142E00B6
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 13:17:42 +0100 (CET)
IronPort-SDR: 67446ae5_C+w4Jc/Az1l8gGl6N7BDh5ugcZLZQyz3gu6dhmemmicYRX3
 yagwhhc16m5baNgl+qguh877+nSmWUweGxYytpQ==
X-IPAS-Result: =?us-ascii?q?A0ERAAAlakRnhVvBS5NaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBAtIhFaIHV+GUYIhA5FKgQUciyyBfg8BAwENRAQBAQMEh?=
 =?us-ascii?q?QACilkCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QEBAUBJhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDX0BAQEBAyMPAQ0BATcBD?=
 =?us-ascii?q?wsVAwICJgICVhmDAYIxAzEDrm56gTKBAYIMAQEG2yYNglAJgRouAYhLAYVQG?=
 =?us-ascii?q?YN9eicbgg2EPz6CH4F7doMOgmmDdYNeJYU2AYNJmzNSexwDWSERAUsKNQw4K?=
 =?us-ascii?q?EkhLAOCR4I1KIEqgkaBFIMugV4FNwqDB4E2NwINAoJFcx+HZoELg15lLwMDA?=
 =?us-ascii?q?wOCExOBGIFrhBsdQAN4PTcUGwahUUaDQQiBPR0uYGULkxeDTwGvd4QkhG+cb?=
 =?us-ascii?q?0WXMJMOiC+QTKNyAYU1gWc6gVwzGggoCIMiTwMZD44hGYh1wkRCNTsCBwEKA?=
 =?us-ascii?q?QEDCZEGNIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 J85q6ZhI4xb55DLhZYUhg==
IronPort-HdrOrdr: A9a23:RQjxQKv4fZRLL3i6jQHiQ8kc7skDc9V00zEX/kB9WHVpmwKj9v
 xGuM5rsiMc7wxhPk3I+OrwXJVoJEmwyXcb2+Us1NuZMzUO/VHYVb2KjrGSpgEIeReOldK1vJ
 0IG8MVNDSzNykZsS+Q2mmF+rgbruW6zA==
X-Talos-CUID: =?us-ascii?q?9a23=3A2nBUYGgDHA6bSA0LgvaTSMN0xDJuUnrX43DffWi?=
 =?us-ascii?q?EC2tPYaeVGAWaopJCjJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AKIbCEw7RyywIAi/yeHDJtHf1xoxRxquOMm1TgKk?=
 =?us-ascii?q?+5eSoaA03BDq9swW4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,182,1728943200"; 
   d="scan'208";a="102556515"
X-MGA-submission: =?us-ascii?q?MDHxwflE+vhxLPEA3pWIiNCttreA4PEkfNGUj/?=
 =?us-ascii?q?4g9Gu1rcLQybURSdi9+x+El5FGNZJEdbG9t5/4ZLZIhPV83b0ZfMzMgC?=
 =?us-ascii?q?pf2jYZlOo9bVPhxPFHmlvvhJIHQWS0+1syhmrGPjl7m7hWhnzPKzO5dP?=
 =?us-ascii?q?EBqIjYJcy3hZnGIK2hqqYekA=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 13:17:40 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A2004A4155E;
	Mon, 25 Nov 2024 12:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B355C4CECE;
	Mon, 25 Nov 2024 12:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732537058;
	bh=+7vDUrAhXkZwpMtioGZjKPSdyrBSkJx5f8rdlaWzKqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/fnt1gzSJFvvynlbkEPVDSLjaw+oZU7IipYcAijkJHf4XfYnLxPXBQ1HDk9D1edo
	 7OKhKUB71YBuCa2eKLOzqEzorUdc3EV9pPRQ+Z0xLBiP84soL4+alum4itV/9NS8MD
	 sDfwyph0x8DH+hy0h7nPRRl7JABfkVqrT71QwIOuZe/k8cVPW1LNdlsSbCQOspl/hW
	 PnRfRbfuOFhoxTrY8geZS/H6j+5DBPr6aAzGOFZzX+gmJ2OoAhizscyLDPuQz0JXhT
	 Vf9lxx86Kpw8v8OxFB2VhNxElc7MN1C+iun2Ac2NE4D5hVEBE4WuVRH6Gotlsm+oow
	 FQYo04vX5eARg==
Date: Mon, 25 Nov 2024 13:17:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: cgzones@googlemail.com
Cc: linux-security-module@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Serge Hallyn <serge@hallyn.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	cocci@inria.fr
Message-ID: <20241125-rausch-sprossen-2570a6fe045a@brauner>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
 <20241125104011.36552-8-cgoettsche@seltendoof.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241125104011.36552-8-cgoettsche@seltendoof.de>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 09/11] fs: reorder capability check last
Reply-To: Christian Brauner <brauner@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2119
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241125-rausch-sprossen-2570a6fe045a%40brauner>

On Mon, Nov 25, 2024 at 11:40:01AM +0100, Christian Göttsche wrote:
> From: Christian Göttsche <cgzones@googlemail.com>
> 
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore
>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited
>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to permit
>      the task the requested capability, while it does not need it,
>      violating the principle of least privilege.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>
