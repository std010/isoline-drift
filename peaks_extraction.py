r_labels = np.zeros(len(t), dtype=int)

for idx in rpeaks:
    if 0 <= idx < len(ecg) and ecg[idx] > 0.1:  # проверка амплитуды > 0.1
        r_labels[idx] = 1

output_df = pd.DataFrame({
    'TIME_s': t,
    'ECG_V': ecg,
    'R_peak': r_labels
})

output_path = r"/content/ECG_with_Rpeaks.tsv"
output_df.to_csv(output_path, sep='\t', index=False, header=False, float_format='%.6f')
