<?php

/* file.twig */
class __TwigTemplate_90e39503d01a116eedd340135879e325 extends Twig_Template
{
    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        $this->parent = $this->env->loadTemplate("layout_page.twig");

        $this->blocks = array(
            'title' => array($this, 'block_title'),
            'content' => array($this, 'block_content'),
        );
    }

    protected function doGetParent(array $context)
    {
        return "layout_page.twig";
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        // line 3
        $context["page"] = "files";
        $this->parent->display($context, array_merge($this->blocks, $blocks));
    }

    // line 5
    public function block_title($context, array $blocks = array())
    {
        echo "GitList";
    }

    // line 7
    public function block_content($context, array $blocks = array())
    {
        // line 8
        echo "    ";
        if (isset($context["breadcrumbs"])) { $_breadcrumbs_ = $context["breadcrumbs"]; } else { $_breadcrumbs_ = null; }
        $this->env->loadTemplate("breadcrumb.twig")->display(array_merge($context, array("breadcrumbs" => $_breadcrumbs_)));
        // line 9
        echo "
    <div class=\"source-view\">
        <div class=\"source-header\">
            <div class=\"meta\"></div>

            <div class=\"btn-group pull-right\">
                <a href=\"";
        // line 15
        if (isset($context["repo"])) { $_repo_ = $context["repo"]; } else { $_repo_ = null; }
        if (isset($context["branch"])) { $_branch_ = $context["branch"]; } else { $_branch_ = null; }
        if (isset($context["file"])) { $_file_ = $context["file"]; } else { $_file_ = null; }
        echo twig_escape_filter($this->env, $this->env->getExtension('routing')->getPath("blob_raw", array("repo" => $_repo_, "commitishPath" => (($_branch_ . "/") . $_file_))), "html", null, true);
        echo "\" class=\"btn btn-small\"><i class=\"icon-file\"></i> Raw</a>
                <a href=\"";
        // line 16
        if (isset($context["repo"])) { $_repo_ = $context["repo"]; } else { $_repo_ = null; }
        if (isset($context["branch"])) { $_branch_ = $context["branch"]; } else { $_branch_ = null; }
        if (isset($context["file"])) { $_file_ = $context["file"]; } else { $_file_ = null; }
        echo twig_escape_filter($this->env, $this->env->getExtension('routing')->getPath("blame", array("repo" => $_repo_, "commitishPath" => (($_branch_ . "/") . $_file_))), "html", null, true);
        echo "\" class=\"btn btn-small\"><i class=\"icon-bullhorn\"></i> Blame</a>
                <a href=\"";
        // line 17
        if (isset($context["repo"])) { $_repo_ = $context["repo"]; } else { $_repo_ = null; }
        if (isset($context["branch"])) { $_branch_ = $context["branch"]; } else { $_branch_ = null; }
        if (isset($context["file"])) { $_file_ = $context["file"]; } else { $_file_ = null; }
        echo twig_escape_filter($this->env, $this->env->getExtension('routing')->getPath("commits", array("repo" => $_repo_, "commitishPath" => (($_branch_ . "/") . $_file_))), "html", null, true);
        echo "\" class=\"btn btn-small\"><i class=\"icon-list-alt\"></i> History</a>
            </div>
        </div>
        ";
        // line 20
        if (isset($context["fileType"])) { $_fileType_ = $context["fileType"]; } else { $_fileType_ = null; }
        if (($_fileType_ == "image")) {
            // line 21
            echo "        <center><img src=\"";
            if (isset($context["repo"])) { $_repo_ = $context["repo"]; } else { $_repo_ = null; }
            if (isset($context["branch"])) { $_branch_ = $context["branch"]; } else { $_branch_ = null; }
            if (isset($context["file"])) { $_file_ = $context["file"]; } else { $_file_ = null; }
            echo twig_escape_filter($this->env, $this->env->getExtension('routing')->getPath("blob_raw", array("repo" => $_repo_, "commitishPath" => (($_branch_ . "/") . $_file_))), "html", null, true);
            echo "\" alt=\"";
            if (isset($context["file"])) { $_file_ = $context["file"]; } else { $_file_ = null; }
            echo twig_escape_filter($this->env, $_file_, "html", null, true);
            echo "\" class=\"image-blob\" /></center>

        ";
        } elseif (($_fileType_ == "markdown")) {
            // line 24
            echo "        <div class=\"md-view\"><div id=\"md-content\">";
            if (isset($context["blob"])) { $_blob_ = $context["blob"]; } else { $_blob_ = null; }
            echo twig_escape_filter($this->env, $_blob_, "html", null, true);
            echo "</div></div>

        ";
        } else {
            // line 27
            echo "        <pre id=\"sourcecode\" language=\"";
            if (isset($context["fileType"])) { $_fileType_ = $context["fileType"]; } else { $_fileType_ = null; }
            echo twig_escape_filter($this->env, $_fileType_, "html", null, true);
            echo "\">";
            if (isset($context["blob"])) { $_blob_ = $context["blob"]; } else { $_blob_ = null; }
            echo htmlspecialchars($_blob_);
            echo "</pre>
        ";
        }
        // line 29
        echo "    </div>

    <hr />
";
    }

    public function getTemplateName()
    {
        return "file.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  109 => 29,  99 => 27,  91 => 24,  78 => 21,  75 => 20,  66 => 17,  59 => 16,  52 => 15,  44 => 9,  40 => 8,  37 => 7,  31 => 5,  26 => 3,);
    }
}
