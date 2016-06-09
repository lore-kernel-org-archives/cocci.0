From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 9 Jun 2016 07:37:58 +0200
Subject: [Cocci] [PATCH] docs/demos: add ++ transformation documentation
 and demos
In-Reply-To: <1465419046-24096-1-git-send-email-mcgrof@kernel.org>
References: <1465419046-24096-1-git-send-email-mcgrof@kernel.org>
Message-ID: <810b9647-022e-6086-0315-46c9014a4c97@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> @@ -851,6 +851,11 @@ rule should apply if rule XXX was never matched at all.
>  
>  \section{Transformation}
>  
> +Coccinelle allows for transformations to enable modifying C code using

How do you think about to omit the word "for" here?


> @@ -1100,6 +1105,138 @@ write
>  Some kinds of terms can only appear in + code.  These include comments,
>  ifdefs, and attributes (\texttt{\_\_attribute\_\_((...))}).
>  
> +\subsection{Advanced transformations}
> +
> +You may run into the situation where grammar you specificy for
> +transformations might associate itself with a few consecutive tokens
> +in code, in such cases Coccinelle cannot gaurantee order when making

How would you like to avoid a typo here?

Regards,
Markus
