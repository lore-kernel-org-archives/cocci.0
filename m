From: eliseomarmol@gmail.com (=?utf-8?Q?Eliseo_Mart=C3=ADnez?=)
Date: Fri, 16 Jan 2015 13:42:31 +0100
Subject: [Cocci] Find all variables/parameters of a given type.
Message-ID: <528DE554-4455-43F3-86D0-A4A1BE677755@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi, 

I?m trying to write a semantic patch to be able to find all `long` variables/function parameters in my code.
I?ve tried a lot of variations, the last of them being:

```
@@ identifier i; @@

* long i;

@@ identifier i, f; @@

(
* f(long i) { ... }
|
* f(long i, ...) { ... }
|
* f(..., long i, ...) { ... }
|
* f(..., long i) { ... }
)
```

But I get parse errors no matter what I try.
Where?s my error? 
