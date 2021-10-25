Return-Path: <SRS0=o+tk=PN=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AC2C433EF
	for <cocci@archiver.kernel.org>; Mon, 25 Oct 2021 16:20:45 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA5960E73
	for <cocci@archiver.kernel.org>; Mon, 25 Oct 2021 16:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CBA5960E73
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AWQPZTKgVqq/lcladkXe9EZI7X161dhEKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUDmGYaWzjUbqvcZTf0fN8kady3p0lXsZfRnIBnTARprnw8FHgiR?=
 =?us-ascii?q?ejtVY3IdB+oV8+xBpSeFxw/t512huEtnanYd1eEzvuWGuWn/SYUOZ2gHOKmUbe?=
 =?us-ascii?q?cYH0pH2eIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYsWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WlYbR6bbewmIkHtfHaa46vRAjnVoguBqb7xFNx0R0mvR9zxy4IwlWZiYQ?=
 =?us-ascii?q?gAiNayJn/sbXgNwEidkPKQA9qWvzX2X6p3IkBGZG5fr67A0ZK0sBqUT/e18AEl?=
 =?us-ascii?q?H7/cYKS4AdFaAiviwzbb9TfNj7uwpLdLwLY0Rkn5lxDDdS/0hRPjrSKLH49Je9?=
 =?us-ascii?q?Dg1j8FKW/3ZYqIxZTNpKhaGfBxLPlYeDYkWk+Khh325eDpdwHqZrLQ273PUygB?=
 =?us-ascii?q?/37zFP9/ce9jMTsJQ9m6UqyTd+HnrC1cRM8aSzyaE9Fqjg+bOmWXwX4d6PLaj6?=
 =?us-ascii?q?/pukXWcwWscDBBQXly+ydGzh0izV9NcN2QU9ysooO4o80eoVbHVVBm/p2WsvB4?=
 =?us-ascii?q?XX91XCKsx7wTl4qbd5QeUAi4AQyxKYdohnMs3QzUw0RmOhdyBLTdvqryOVXWF9?=
 =?us-ascii?q?vGeqj6yPDccKWMPfwcATA0P4sWlq4Y25i8j5P4L/LWdlsfyFXT0wiuWoTMj3uV?=
 =?us-ascii?q?VjMgR1qz980qvvt5lnbCRJiZd2+kddjnNAttFWbOY?=
X-IronPort-AV: E=Sophos;i="5.87,181,1631570400"; 
   d="scan'208";a="393747"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Oct 2021 18:20:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D01B7E001B; Mon, 25 Oct 2021 18:20:42 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C978CE0018
	for <cocci@sympa.inria.fr>; Mon, 25 Oct 2021 18:20:39 +0200 (CEST)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=joe@perches.com; spf=None smtp.mailfrom=joe@perches.com; spf=None smtp.helo=postmaster@smtprelay.hostedemail.com
IronPort-PHdr: =?us-ascii?q?A9a23=3AOjLRPhHjBdNu8ytyjiZLp51Gf+hMhN3EVzX9CrI?=
 =?us-ascii?q?Zgr5DOp6u447ldBSGo6k31BmYBM6GtLptsKn/i+jYQ2sO4JKM4jgpUadncFs7s?=
 =?us-ascii?q?/gQhBEqG8WfCEf2f7bAZi0+G9leBhc+pynoeUdaF9zjaFLMv3a88SAdGgnlNQp?=
 =?us-ascii?q?yO+/5BpPeg9642uys55HfeQFFiCeybb5yLhi9sBncuNQRjYZ+MKg61wHHomFPe?=
 =?us-ascii?q?+RYxGNoIUyckhPh7cqu/5Bt7jpdtes5+8FPTav1caI4TadFDDs9KGA6+NfrtRj?=
 =?us-ascii?q?YQgSR4HYXT3gbnQBJAwjB6xH6Q4vxvy7nvedzxCWWIcv7Rq0vVD+886lkVgPni?=
 =?us-ascii?q?CYfNz447m7XjNBwjLlGqx6lvhBz3pLYbJ2QOPd4Y6jTf84VRXBZU8hSSiJPAp2?=
 =?us-ascii?q?yYYUNAOoPIelXoYbyqVQVoBuiBwShHv/jxiNSi3Pr26AxzuQvERvB3AwlB98At?=
 =?us-ascii?q?HPUo8voP6kIT++11rXHzTXdYPNNxDzw74rIchc/rvyXRbJ/b9DRxlUvFwzblVW?=
 =?us-ascii?q?cs5DqPzSQ1ukUtWWQ8uVvW/61hWE9twFxviagxt0qioTRgo8YxUzI+CV2zYs7O?=
 =?us-ascii?q?NG2SFN2bNy4HJZSqyyWKpd7T8MgTm11tyg3xLILt5C4cSYFypkqyRrSZ+KHfYa?=
 =?us-ascii?q?H/h7uSuCcKip7inJ9YL+zmQu+/Em6xuDzSsW4yllHoyVfntXRsn0A0wTf5taaR?=
 =?us-ascii?q?vZ85Eus1iqD2xrd5+xHO0w5lLbXJpg8ybAqjJUTq17MHirulUX2kqCWckIk9/C?=
 =?us-ascii?q?z6+TifrXmvoWcOJFwig7kMqUigMy/AeMjMggSQWeU5Pqz1Lj58k34RLVGlOE5k?=
 =?us-ascii?q?q7csJzCJMQboLC2AxNN34o99hqyDi2q3dsEkXUdI19IdwiLg5XtNlzKOPz4CO2?=
 =?us-ascii?q?wg1WokDdl3fDGObjhD43PLnjEjrjsZq595FBGyAUvzdBQ+YlUBqsdL/L0X0/9r?=
 =?us-ascii?q?MbYAQMhMwyo3+bnD81w2Z8ZWW2THqCZMbjfsUSI5+IqO+mDfpUZuDf7K/g/5v7?=
 =?us-ascii?q?hl2U1mVEHffrh4ZxCR2q1EbxFOUKQYT/Mi80dFG4M9l4xVuHli12qVT9Vema8W?=
 =?us-ascii?q?L866jgnCYWgS4DZSdb+rqaG2XKZGZAeXm1cAVCBCj+8dYKJc+8BcimSL9QnmTs?=
 =?us-ascii?q?BA+vyA7Q93A2j4Vepg4FsKfDZr2hB7cqLPD1d/+DJnhE/7np/CMHPiwlloElsk?=
 =?us-ascii?q?3kDRzItmqt4pB4lor9i+bN9n+RCGNha9rVJVRwmOJLRyuV7D5b5XQeTJr+0?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Av2opLqOhG+8gtMBcTkyjsMiBIKoaSvp037Dk?=
 =?us-ascii?q?7SFMoHtuA6qlfqGV7ZEmPHDP6Ar5NEtOpTnEAtjifZq+z+8T3WByB9qftWDd0Q?=
 =?us-ascii?q?PCRr2Kr7GSoQEIcBeTygcy78ldmuRFebnNJGk/rOq/3QG3euxQv+WvweSSn/7X?=
 =?us-ascii?q?y3oodR1nd60lzwoRMHfgLmRGADJdHJI8Gd6n6tFZqyHIQwVtUu2LQkMIRfLCod?=
 =?us-ascii?q?qOtL+OW297OzcXrDODlymp7rm/NxCC3BsEOgk/vIvK71K16jDR1+GYrvmnjiXd?=
 =?us-ascii?q?2Wja8ohMlLLau6N+OPA=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AAAQASaxphh8csKNhagQmBWYN5KBKNf?=
 =?us-ascii?q?IgCaoE9miuBfAsBAwENQQQBAYRhAoJsHgYGMAkOAQIEFQEBBQEBAQIBAwMEARM?=
 =?us-ascii?q?BAQEBDQsOCDokhXWCNSkBg2QBAgN5EAsYHBJXBoMEgwgFAadzgTOBAYRpg06BY?=
 =?us-ascii?q?4E6jXNDP4FOhDo+ij8EmjSNSAFfnRuDMoE3nUaDUwGjIbtWAYFfghRNIxWDJU8?=
 =?us-ascii?q?ZDo45jlchagIGCwEBAwmJdQEB?=
X-IPAS-Result: =?us-ascii?q?A0AAAQASaxphh8csKNhagQmBWYN5KBKNfIgCaoE9miuBfAs?=
 =?us-ascii?q?BAwENQQQBAYRhAoJsHgYGMAkOAQIEFQEBBQEBAQIBAwMEARMBAQEBDQsOCDokh?=
 =?us-ascii?q?XWCNSkBg2QBAgN5EAsYHBJXBoMEgwgFAadzgTOBAYRpg06BY4E6jXNDP4FOhDo?=
 =?us-ascii?q?+ij8EmjSNSAFfnRuDMoE3nUaDUwGjIbtWAYFfghRNIxWDJU8ZDo45jlchagIGC?=
 =?us-ascii?q?wEBAwmJdQEB?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397318291"
X-MGA-submission: =?us-ascii?q?MDGgAFL+RJieMZ1aGdMEyYPxsJrC5m0YoNCMOM?=
 =?us-ascii?q?45/OlplCSp+hmQNgp9sECHDJB/f51OMwZAyNxM1EiNUkc5tjs82HkNG1?=
 =?us-ascii?q?z48yONFgkwe2VDpBWb+QzN2MJxrVxg/HW1g0T+HQdUyse/U8eAOPincR?=
 =?us-ascii?q?rtAM8v3AML9mUKGdcB7Bd9MQ=3D=3D?=
Received: from smtprelay0199.hostedemail.com (HELO smtprelay.hostedemail.com) ([216.40.44.199])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 18:20:14 +0200
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
	by smtprelay02.hostedemail.com (Postfix) with ESMTP id F1E1330C9F;
	Mon, 25 Oct 2021 16:20:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 872D5D1513;
	Mon, 25 Oct 2021 16:20:11 +0000 (UTC)
Message-ID: <a1e76a303ec4dc1ffd53e1d22634363bdb0ffcd0.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, Johan Hovold
 <johan@kernel.org>,  cocci@inria.fr, Florian Schilhabel
 <florian.c.schilhabel@googlemail.com>,  linux-staging@lists.linux.dev,
 linux-usb@vger.kernel.org,  linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Mon, 25 Oct 2021 09:20:10 -0700
In-Reply-To: <YXbSfYIuyj3PI6pm@kroah.com>
References: <20211025120910.6339-1-johan@kernel.org>
	 <20211025120910.6339-2-johan@kernel.org>
	 <fdb677be-6e06-fef9-811d-bb2c71246197@lwfinger.net>
	 <094a8f50ccef81e0317c89d0a605c327c825d5cb.camel@perches.com>
	 <YXbSfYIuyj3PI6pm@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: s57wnjk3sazm6ya3cfjfmqterpgjdyme
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 872D5D1513
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18H09QZhcxyfnc+dKXrrgxF7zoOKHJVloU=
X-HE-Tag: 1635178811-876912
Subject: Re: [cocci] [PATCH 1/2] staging: rtl8192u: fix control-message
 timeouts
Reply-To: Joe Perches <joe@perches.com>
X-Loop: cocci@inria.fr
X-Sequence: 34
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/a1e76a303ec4dc1ffd53e1d22634363bdb0ffcd0.camel%40perches.com>

On Mon, 2021-10-25 at 17:51 +0200, Greg Kroah-Hartman wrote:
> Look at the lists, he's sent a bunch of fixes for this today to all the
> subsystems...

Yay Johan. Thanks for doing all of them...

