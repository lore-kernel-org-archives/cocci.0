From: joe@perches.com (Joe Perches)
Date: Thu, 19 Jun 2014 09:34:22 -0700
Subject: [Cocci] [PATCH] Coccinelle: Script to drop parenthesis in the
 return statements
In-Reply-To: <20140619162954.GA4698@himangi-Dell>
References: <20140619162954.GA4698@himangi-Dell>
Message-ID: <1403195662.7875.5.camel@joe-AO725>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 2014-06-19 at 21:59 +0530, Himangi Saraogi wrote:
> This script detects the use of a parenthesis around return value ot the
> return statements and removes them as they are unnecessary and against
> the CodingStyle. A new directory called checkpatch is added for semantic
> patches that just make patches for what checkpatch does. This will help
> developers having checkpatch problems, to run the semantic patches in this
> directory on their code and fix some of them automatically.

checkpatch already has --fix and --fix-inplace options that
do something similar.
