<?php

/* layout.twig */
class __TwigTemplate_7447c7426f5c7e813fdb6ffa5003048a extends Twig_Template
{
    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        $this->parent = false;

        $this->blocks = array(
            'title' => array($this, 'block_title'),
            'body' => array($this, 'block_body'),
        );
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        // line 1
        echo "<!DOCTYPE html>
<html lang=\"en\">
    <head>
        <meta charset=\"UTF-8\" />
        <title>";
        // line 5
        $this->displayBlock('title', $context, $blocks);
        echo "</title>
        <link rel=\"stylesheet\" type=\"text/css\" href=\"";
        // line 6
        if (isset($context["app"])) { $_app_ = $context["app"]; } else { $_app_ = null; }
        echo twig_escape_filter($this->env, $this->getAttribute($this->getAttribute($_app_, "request"), "basepath"), "html", null, true);
        echo "/web/css/style.css\">
        <link rel=\"shortcut icon\" type=\"image/png\" href=\"";
        // line 7
        if (isset($context["app"])) { $_app_ = $context["app"]; } else { $_app_ = null; }
        echo twig_escape_filter($this->env, $this->getAttribute($this->getAttribute($_app_, "request"), "basepath"), "html", null, true);
        echo "/web/img/favicon.png\" />
        <!--[if lt IE 9]>
        <script src=\"";
        // line 9
        if (isset($context["app"])) { $_app_ = $context["app"]; } else { $_app_ = null; }
        echo twig_escape_filter($this->env, $this->getAttribute($this->getAttribute($_app_, "request"), "basepath"), "html", null, true);
        echo "/web/js/html5.js\"></script>
        <![endif]-->
    </head>

    <body>
        ";
        // line 14
        $this->displayBlock('body', $context, $blocks);
        // line 15
        echo "        <script src=\"";
        if (isset($context["app"])) { $_app_ = $context["app"]; } else { $_app_ = null; }
        echo twig_escape_filter($this->env, $this->getAttribute($this->getAttribute($_app_, "request"), "basepath"), "html", null, true);
        echo "/web/js/jquery.js\"></script>
        <script src=\"";
        // line 16
        if (isset($context["app"])) { $_app_ = $context["app"]; } else { $_app_ = null; }
        echo twig_escape_filter($this->env, $this->getAttribute($this->getAttribute($_app_, "request"), "basepath"), "html", null, true);
        echo "/web/js/bootstrap.js\"></script>
        <script src=\"";
        // line 17
        if (isset($context["app"])) { $_app_ = $context["app"]; } else { $_app_ = null; }
        echo twig_escape_filter($this->env, $this->getAttribute($this->getAttribute($_app_, "request"), "basepath"), "html", null, true);
        echo "/web/js/codemirror.js\"></script>
        <script src=\"";
        // line 18
        if (isset($context["app"])) { $_app_ = $context["app"]; } else { $_app_ = null; }
        echo twig_escape_filter($this->env, $this->getAttribute($this->getAttribute($_app_, "request"), "basepath"), "html", null, true);
        echo "/web/js/showdown.js\"></script>
        <script src=\"";
        // line 19
        if (isset($context["app"])) { $_app_ = $context["app"]; } else { $_app_ = null; }
        echo twig_escape_filter($this->env, $this->getAttribute($this->getAttribute($_app_, "request"), "basepath"), "html", null, true);
        echo "/web/js/main.js\"></script>
    </body>
</html>
";
    }

    // line 5
    public function block_title($context, array $blocks = array())
    {
        echo "Welcome!";
    }

    // line 14
    public function block_body($context, array $blocks = array())
    {
    }

    public function getTemplateName()
    {
        return "layout.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  89 => 14,  74 => 19,  64 => 17,  59 => 16,  53 => 15,  51 => 14,  42 => 9,  36 => 7,  31 => 6,  27 => 5,  21 => 1,  98 => 28,  96 => 27,  91 => 24,  83 => 5,  79 => 19,  72 => 17,  69 => 18,  62 => 13,  54 => 12,  50 => 10,  45 => 9,  40 => 6,  38 => 5,  35 => 4,  29 => 2,);
    }
}
