<?php

/* menu.twig */
class __TwigTemplate_90e6293d9569ff9ad5c2cdef110c04ab extends Twig_Template
{
    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        $this->parent = false;

        $this->blocks = array(
        );
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        // line 1
        echo "<ul class=\"nav nav-tabs\">
    <li";
        // line 2
        if (isset($context["page"])) { $_page_ = $context["page"]; } else { $_page_ = null; }
        if (($_page_ == "files")) {
            echo " class=\"active\"";
        }
        echo "><a href=\"";
        if (isset($context["repo"])) { $_repo_ = $context["repo"]; } else { $_repo_ = null; }
        if (isset($context["branch"])) { $_branch_ = $context["branch"]; } else { $_branch_ = null; }
        echo twig_escape_filter($this->env, $this->env->getExtension('routing')->getPath("branch", array("repo" => $_repo_, "branch" => $_branch_)), "html", null, true);
        echo "\">Files</a></li>
    <li";
        // line 3
        if (isset($context["page"])) { $_page_ = $context["page"]; } else { $_page_ = null; }
        if (twig_in_filter($_page_, array(0 => "commits", 1 => "searchcommits"))) {
            echo " class=\"active\"";
        }
        echo "><a href=\"";
        if (isset($context["repo"])) { $_repo_ = $context["repo"]; } else { $_repo_ = null; }
        if (isset($context["branch"])) { $_branch_ = $context["branch"]; } else { $_branch_ = null; }
        echo twig_escape_filter($this->env, $this->env->getExtension('routing')->getPath("commits", array("repo" => $_repo_, "commitishPath" => $_branch_)), "html", null, true);
        echo "\">Commits</a></li>
    <li";
        // line 4
        if (isset($context["page"])) { $_page_ = $context["page"]; } else { $_page_ = null; }
        if (($_page_ == "stats")) {
            echo " class=\"active\"";
        }
        echo "><a href=\"";
        if (isset($context["repo"])) { $_repo_ = $context["repo"]; } else { $_repo_ = null; }
        if (isset($context["branch"])) { $_branch_ = $context["branch"]; } else { $_branch_ = null; }
        echo twig_escape_filter($this->env, $this->env->getExtension('routing')->getPath("stats", array("repo" => $_repo_, "branch" => $_branch_)), "html", null, true);
        echo "\">Stats</a></li>
</ul>
";
    }

    public function getTemplateName()
    {
        return "menu.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  33 => 3,  60 => 11,  55 => 10,  52 => 9,  48 => 8,  34 => 6,  22 => 2,  19 => 1,  107 => 27,  102 => 30,  100 => 29,  97 => 28,  90 => 24,  85 => 22,  82 => 21,  77 => 14,  74 => 13,  59 => 14,  41 => 9,  35 => 5,  32 => 4,  29 => 5,  253 => 15,  243 => 13,  234 => 12,  230 => 10,  227 => 9,  180 => 69,  173 => 66,  167 => 64,  163 => 62,  159 => 61,  155 => 59,  150 => 56,  136 => 53,  131 => 52,  125 => 51,  118 => 49,  111 => 47,  108 => 46,  104 => 45,  101 => 44,  95 => 27,  88 => 23,  79 => 20,  71 => 34,  68 => 33,  64 => 31,  61 => 30,  50 => 21,  47 => 20,  44 => 4,  40 => 8,  37 => 7,  31 => 5,  26 => 3,);
    }
}
