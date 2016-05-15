// This file was generated by Rcpp::compileAttributes
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <RcppArmadillo.h>
#include <Rcpp.h>

using namespace Rcpp;

// demographic_stochast
NumericVector demographic_stochast(NumericVector v, NumericMatrix tmat);
RcppExport SEXP dlmpr_demographic_stochast(SEXP vSEXP, SEXP tmatSEXP) {
BEGIN_RCPP
    Rcpp::RObject __result;
    Rcpp::RNGScope __rngScope;
    Rcpp::traits::input_parameter< NumericVector >::type v(vSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type tmat(tmatSEXP);
    __result = Rcpp::wrap(demographic_stochast(v, tmat));
    return __result;
END_RCPP
}
// envir_stochast
NumericMatrix envir_stochast(NumericMatrix tmat, NumericMatrix sdmat, bool equalsign);
RcppExport SEXP dlmpr_envir_stochast(SEXP tmatSEXP, SEXP sdmatSEXP, SEXP equalsignSEXP) {
BEGIN_RCPP
    Rcpp::RObject __result;
    Rcpp::RNGScope __rngScope;
    Rcpp::traits::input_parameter< NumericMatrix >::type tmat(tmatSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type sdmat(sdmatSEXP);
    Rcpp::traits::input_parameter< bool >::type equalsign(equalsignSEXP);
    __result = Rcpp::wrap(envir_stochast(tmat, sdmat, equalsign));
    return __result;
END_RCPP
}
// demo_proj
NumericVector demo_proj(NumericVector v0, NumericMatrix tmat, Rcpp::Nullable<Rcpp::NumericMatrix> matsd, Rcpp::Nullable<Rcpp::NumericMatrix> stmat, bool estamb, bool estdem, bool equalsign, bool tmat_fecundity);
RcppExport SEXP dlmpr_demo_proj(SEXP v0SEXP, SEXP tmatSEXP, SEXP matsdSEXP, SEXP stmatSEXP, SEXP estambSEXP, SEXP estdemSEXP, SEXP equalsignSEXP, SEXP tmat_fecunditySEXP) {
BEGIN_RCPP
    Rcpp::RObject __result;
    Rcpp::RNGScope __rngScope;
    Rcpp::traits::input_parameter< NumericVector >::type v0(v0SEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type tmat(tmatSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<Rcpp::NumericMatrix> >::type matsd(matsdSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<Rcpp::NumericMatrix> >::type stmat(stmatSEXP);
    Rcpp::traits::input_parameter< bool >::type estamb(estambSEXP);
    Rcpp::traits::input_parameter< bool >::type estdem(estdemSEXP);
    Rcpp::traits::input_parameter< bool >::type equalsign(equalsignSEXP);
    Rcpp::traits::input_parameter< bool >::type tmat_fecundity(tmat_fecunditySEXP);
    __result = Rcpp::wrap(demo_proj(v0, tmat, matsd, stmat, estamb, estdem, equalsign, tmat_fecundity));
    return __result;
END_RCPP
}
// demo_proj_n_cpp
List demo_proj_n_cpp(List vn, NumericMatrix tmat, Rcpp::Nullable<Rcpp::NumericMatrix> matsd, Rcpp::Nullable<Rcpp::NumericMatrix> stmat, bool estamb, bool estdem, bool equalsign, bool tmat_fecundity, int nrep, int time);
RcppExport SEXP dlmpr_demo_proj_n_cpp(SEXP vnSEXP, SEXP tmatSEXP, SEXP matsdSEXP, SEXP stmatSEXP, SEXP estambSEXP, SEXP estdemSEXP, SEXP equalsignSEXP, SEXP tmat_fecunditySEXP, SEXP nrepSEXP, SEXP timeSEXP) {
BEGIN_RCPP
    Rcpp::RObject __result;
    Rcpp::RNGScope __rngScope;
    Rcpp::traits::input_parameter< List >::type vn(vnSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type tmat(tmatSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<Rcpp::NumericMatrix> >::type matsd(matsdSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<Rcpp::NumericMatrix> >::type stmat(stmatSEXP);
    Rcpp::traits::input_parameter< bool >::type estamb(estambSEXP);
    Rcpp::traits::input_parameter< bool >::type estdem(estdemSEXP);
    Rcpp::traits::input_parameter< bool >::type equalsign(equalsignSEXP);
    Rcpp::traits::input_parameter< bool >::type tmat_fecundity(tmat_fecunditySEXP);
    Rcpp::traits::input_parameter< int >::type nrep(nrepSEXP);
    Rcpp::traits::input_parameter< int >::type time(timeSEXP);
    __result = Rcpp::wrap(demo_proj_n_cpp(vn, tmat, matsd, stmat, estamb, estdem, equalsign, tmat_fecundity, nrep, time));
    return __result;
END_RCPP
}
// meta_dispersal_fun
NumericMatrix meta_dispersal_fun(NumericMatrix dist, double alpha, double beta, bool hanski_dispersal_kernal);
RcppExport SEXP dlmpr_meta_dispersal_fun(SEXP distSEXP, SEXP alphaSEXP, SEXP betaSEXP, SEXP hanski_dispersal_kernalSEXP) {
BEGIN_RCPP
    Rcpp::RObject __result;
    Rcpp::RNGScope __rngScope;
    Rcpp::traits::input_parameter< NumericMatrix >::type dist(distSEXP);
    Rcpp::traits::input_parameter< double >::type alpha(alphaSEXP);
    Rcpp::traits::input_parameter< double >::type beta(betaSEXP);
    Rcpp::traits::input_parameter< bool >::type hanski_dispersal_kernal(hanski_dispersal_kernalSEXP);
    __result = Rcpp::wrap(meta_dispersal_fun(dist, alpha, beta, hanski_dispersal_kernal));
    return __result;
END_RCPP
}
// metapop
NumericVector metapop(NumericVector presence, NumericMatrix dist_mat, NumericVector Ei, double y);
RcppExport SEXP dlmpr_metapop(SEXP presenceSEXP, SEXP dist_matSEXP, SEXP EiSEXP, SEXP ySEXP) {
BEGIN_RCPP
    Rcpp::RObject __result;
    Rcpp::RNGScope __rngScope;
    Rcpp::traits::input_parameter< NumericVector >::type presence(presenceSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type dist_mat(dist_matSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type Ei(EiSEXP);
    Rcpp::traits::input_parameter< double >::type y(ySEXP);
    __result = Rcpp::wrap(metapop(presence, dist_mat, Ei, y));
    return __result;
END_RCPP
}
// metapop_n
NumericMatrix metapop_n(int time, NumericMatrix dist, NumericVector area, NumericVector presence, double y, double x, double e, double alpha, double beta, bool hanski_dispersal_kernal, Rcpp::Nullable<Rcpp::NumericMatrix> locations);
RcppExport SEXP dlmpr_metapop_n(SEXP timeSEXP, SEXP distSEXP, SEXP areaSEXP, SEXP presenceSEXP, SEXP ySEXP, SEXP xSEXP, SEXP eSEXP, SEXP alphaSEXP, SEXP betaSEXP, SEXP hanski_dispersal_kernalSEXP, SEXP locationsSEXP) {
BEGIN_RCPP
    Rcpp::RObject __result;
    Rcpp::RNGScope __rngScope;
    Rcpp::traits::input_parameter< int >::type time(timeSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type dist(distSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type area(areaSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type presence(presenceSEXP);
    Rcpp::traits::input_parameter< double >::type y(ySEXP);
    Rcpp::traits::input_parameter< double >::type x(xSEXP);
    Rcpp::traits::input_parameter< double >::type e(eSEXP);
    Rcpp::traits::input_parameter< double >::type alpha(alphaSEXP);
    Rcpp::traits::input_parameter< double >::type beta(betaSEXP);
    Rcpp::traits::input_parameter< bool >::type hanski_dispersal_kernal(hanski_dispersal_kernalSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<Rcpp::NumericMatrix> >::type locations(locationsSEXP);
    __result = Rcpp::wrap(metapop_n(time, dist, area, presence, y, x, e, alpha, beta, hanski_dispersal_kernal, locations));
    return __result;
END_RCPP
}
// metapop_n_cpp
List metapop_n_cpp(int nrep, int time, NumericMatrix dist, NumericVector area, NumericVector presence, double y, double x, double e, double alpha, double beta, bool hanski_dispersal_kernal, Rcpp::Nullable<Rcpp::NumericMatrix> locations);
RcppExport SEXP dlmpr_metapop_n_cpp(SEXP nrepSEXP, SEXP timeSEXP, SEXP distSEXP, SEXP areaSEXP, SEXP presenceSEXP, SEXP ySEXP, SEXP xSEXP, SEXP eSEXP, SEXP alphaSEXP, SEXP betaSEXP, SEXP hanski_dispersal_kernalSEXP, SEXP locationsSEXP) {
BEGIN_RCPP
    Rcpp::RObject __result;
    Rcpp::RNGScope __rngScope;
    Rcpp::traits::input_parameter< int >::type nrep(nrepSEXP);
    Rcpp::traits::input_parameter< int >::type time(timeSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type dist(distSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type area(areaSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type presence(presenceSEXP);
    Rcpp::traits::input_parameter< double >::type y(ySEXP);
    Rcpp::traits::input_parameter< double >::type x(xSEXP);
    Rcpp::traits::input_parameter< double >::type e(eSEXP);
    Rcpp::traits::input_parameter< double >::type alpha(alphaSEXP);
    Rcpp::traits::input_parameter< double >::type beta(betaSEXP);
    Rcpp::traits::input_parameter< bool >::type hanski_dispersal_kernal(hanski_dispersal_kernalSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<Rcpp::NumericMatrix> >::type locations(locationsSEXP);
    __result = Rcpp::wrap(metapop_n_cpp(nrep, time, dist, area, presence, y, x, e, alpha, beta, hanski_dispersal_kernal, locations));
    return __result;
END_RCPP
}
