use pyo3::prelude::*;
use bardecoder;

#[pyfunction]
fn decode_from_file(image_location: String) -> PyResult<String> {
    let img = image::open(image_location).unwrap();
    let decoder = bardecoder::default_decoder();
    let results = decoder.decode(&img);

    let resp = results
        .into_iter()
        .filter_map(Result::ok)
        .next()
        .unwrap_or_else(String::new);

    Ok(resp)
}

#[pymodule]
fn pybardecoder(m: &Bound<'_, PyModule>) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(decode_from_file, m)?)?;
    Ok(())
}
