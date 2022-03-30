Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF8EC433EF
	for <cocci@archiver.kernel.org>; Wed, 30 Mar 2022 08:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=UxW2mD5WrICDvibAp5foCegbS/EQTtzvOwwvmmQ2hgk=;
  b=K02wwnQZRAu/Ft2hrD94vo/ZEhzWQG9gShFht1IvNChYTXNqgpqjTE7O
   AXlwAV+Uje1rAMqRM5+nUEInJKsSVCiUHHUGzJ1MGTe8WuTqEBJ9xjwPV
   Dp4PR2eDNIPudomVq824u3QCa6ZyIfGIrYsevMnNHMMu2heuuVZr8oblg
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.90,222,1643670000"; 
   d="scan'208";a="29029338"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Mar 2022 10:04:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2C5BAE7D85; Wed, 30 Mar 2022 10:04:41 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9667DE7D80
	for <cocci@sympa.inria.fr>; Wed, 30 Mar 2022 10:04:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UxW2mD5WrICDvibAp5foCegbS/EQTtzvOwwvmmQ2hgk=;
  b=YcNRZzjsrXHrXNzg16ojqkJ8iqhLmsvXBJAxBShDwvZh0fnvAH4KQISA
   3YwsV/SqmfC4w9S9UrSHmdFORW1S5lcqW0Ot4zMsN38fWtpwM7JtA8tK5
   io94IeIb+7SFszSh+4lU6idrt9kaOhYBiuvGIkQLt6fmQoJJuEhwnrF8H
   E=;
X-IronPort-AV: E=Sophos;i="5.90,222,1643670000"; 
   d="scan'208";a="29029302"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 10:04:35 +0200
Date: Wed, 30 Mar 2022 10:04:31 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
cc: corbet@lwn.net, mchehab+huawei@kernel.org, dlatypov@google.com, 
    davidgow@google.com, linux-doc@vger.kernel.org, 
    linux-sparse@vger.kernel.org, cocci@inria.fr, smatch@vger.kernel.org, 
    linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
    dan.carpenter@oracle.com, julia.lawall@inria.fr
In-Reply-To: <9b8233e89227617a2cb47d85c654603c6583323d.1648593132.git.marcelo.schmitt1@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2203301003580.2592@hadrien>
References: <cover.1648593132.git.marcelo.schmitt1@gmail.com> <9b8233e89227617a2cb47d85c654603c6583323d.1648593132.git.marcelo.schmitt1@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v2 1/2] Documentation: dev-tools: Add a section
 for static analysis tools
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 313
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203301003580.2592%40hadrien>



On Tue, 29 Mar 2022, Marcelo Schmitt wrote:

> Complement the Kernel Testing Guide documentation page by adding a
> section about static analysis tools.
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: David Gow <davidgow@google.com>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Acked-by: Julia Lawall <julia.lawall@inria.fr>

> ---
> Change log:
> - Brought generic tool characteristics to the intro paragraph
> - Made explicit that these tools run at compile time
> - Added a note of caution about false positives
> - Updated Coccinelle info to make it sound better and be more skimmable
>
>  Documentation/dev-tools/testing-overview.rst | 31 ++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
> index 65feb81edb14..b5e02dd3fd94 100644
> --- a/Documentation/dev-tools/testing-overview.rst
> +++ b/Documentation/dev-tools/testing-overview.rst
> @@ -115,3 +115,34 @@ that none of these errors are occurring during the test.
>  Some of these tools integrate with KUnit or kselftest and will
>  automatically fail tests if an issue is detected.
>
> +Static Analysis Tools
> +=====================
> +
> +In addition to testing a running kernel, one can also analyze kernel source code
> +directly (**at compile time**) using **static analysis** tools. The tools
> +commonly used in the kernel allow one to inspect the whole source tree or just
> +specific files within it. They make it easier to detect and fix problems during
> +the development process.
> +
> +Sparse can help test the kernel by performing type-checking, lock checking,
> +value range checking, in addition to reporting various errors and warnings while
> +examining the code. See the Documentation/dev-tools/sparse.rst documentation
> +page for details on how to use it.
> +
> +Smatch extends Sparse and provides additional checks for programming logic
> +mistakes such as missing breaks in switch statements, unused return values on
> +error checking, forgetting to set an error code in the return of an error path,
> +etc. Smatch also has tests against more serious issues such as integer
> +overflows, null pointer dereferences, and memory leaks. See the project page at
> +http://smatch.sourceforge.net/.
> +
> +Coccinelle is another static analyzer at our disposal. Coccinelle is often used
> +to aid refactoring and collateral evolution of source code, but it can also help
> +to avoid certain bugs that occur in common code patterns. The types of tests
> +available include API tests, tests for correct usage of kernel iterators, checks
> +for the soundness of free operations, analysis of locking behavior, and further
> +tests known to help keep consistent kernel usage. See the
> +Documentation/dev-tools/coccinelle.rst documentation page for details.
> +
> +Beware, though, that static analysis tools suffer from **false positives**.
> +Errors and warns need to be evaluated carefully before attempting to fix them.
> --
> 2.35.1
>
>
