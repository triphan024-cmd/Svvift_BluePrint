const fs = require('fs');

let content = fs.readFileSync('index.html', 'utf8');

// Phase I updates
const oldPhase1Inner = `<div style="display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 0.5rem; margin-bottom: 1.5rem; border-bottom: 2px solid rgba(220,38,38,0.1); padding-bottom: 0.75rem;">
                                <h3 style="font-size: 1.25rem; font-weight: 800; color: #DC2626; text-transform: uppercase; letter-spacing: 0.5px; margin: 0; display: flex; align-items: center; gap: 10px;">
                                    <span>🔍</span> I. VỊ THẾ HIỆN TẠI CỦA CHÚNG TA
                                </h3>
                                <span style="font-size: 0.75rem; font-weight: 800; color: #DC2626; background: rgba(220,38,38,0.08); padding: 4px 12px; border-radius: 20px;">TRUTH AUDIT</span>
                            </div>`;
                            
content = content.replace(oldPhase1Inner, '');

const newPhase1Header = `<div class="section-header observe" style="text-align: center; margin-top: 1rem; margin-bottom: 2rem; position: relative;">
                            <div style="display: inline-flex; align-items: center; gap: 8px; background: rgba(220,38,38,0.06); border: 1px solid rgba(220,38,38,0.15); padding: 5px 16px; border-radius: 20px; margin-bottom: 0.5rem;">
                                <span style="font-size: 0.75rem; font-weight: 800; color: #DC2626; text-transform: uppercase; letter-spacing: 2px;">⚠️ PHẦN I — TRUTH AUDIT</span>
                            </div>
                            <h2 class="section-title" style="margin: 0; font-size: clamp(1.8rem, 3.2vw, 2.6rem); line-height: 1.25; text-transform: uppercase;">
                                <span style="background: linear-gradient(135deg, #DC2626 0%, #B91C1C 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; font-weight: 900;">I. VỊ THẾ HIỆN TẠI CỦA CHÚNG TA</span>
                            </h2>
                            <div style="width: 60px; height: 4px; background: linear-gradient(90deg, #DC2626, #991B1B); margin: 0.75rem auto 0; border-radius: 4px;"></div>
                        </div>`;

content = content.replace('<div id="phan1-truth"', newPhase1Header + '\n                        <div id="phan1-truth"');

// Phase II updates
const oldPhase2Inner = `<div style="display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 0.5rem; margin-bottom: 1.5rem; border-bottom: 2px solid rgba(30,58,138,0.1); padding-bottom: 0.75rem;">
                                <h3 style="font-size: 1.25rem; font-weight: 800; color: var(--accent-primary); text-transform: uppercase; letter-spacing: 0.5px; margin: 0; display: flex; align-items: center; gap: 10px;">
                                    <span>🌍</span> TẦM NHÌN, CẢM HỨNG & TIÊU CHUẨN QUỐC TẾ
                                </h3>
                                <span style="font-size: 0.75rem; font-weight: 800; color: var(--accent-primary); background: rgba(30,58,138,0.08); padding: 4px 12px; border-radius: 20px;">GLOBAL STANDARDS</span>
                            </div>`;

content = content.replace(oldPhase2Inner, '');

const newPhase2Header = `<div class="section-header observe" style="text-align: center; margin-top: 1rem; margin-bottom: 2rem; position: relative;">
                            <div style="display: inline-flex; align-items: center; gap: 8px; background: rgba(30,58,138,0.06); border: 1px solid rgba(30,58,138,0.15); padding: 5px 16px; border-radius: 20px; margin-bottom: 0.5rem;">
                                <span style="font-size: 0.75rem; font-weight: 800; color: var(--accent-primary); text-transform: uppercase; letter-spacing: 2px;">🌍 PHẦN II — GLOBAL STANDARDS</span>
                            </div>
                            <h2 class="section-title" style="margin: 0; font-size: clamp(1.8rem, 3.2vw, 2.6rem); line-height: 1.25; text-transform: uppercase;">
                                <span style="background: linear-gradient(135deg, #1E3A8A 0%, #3B82F6 50%, #10B981 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; font-weight: 900;">TẦM NHÌN, CẢM HỨNG & TIÊU CHUẨN QUỐC TẾ</span>
                            </h2>
                            <div style="width: 60px; height: 4px; background: linear-gradient(90deg, #1E3A8A, #10B981); margin: 0.75rem auto 0; border-radius: 4px;"></div>
                        </div>`;

content = content.replace('<div id="phan2-vision"', newPhase2Header + '\n                        <div id="phan2-vision"');


// Fix Tool-App block which failed in multi_replace_file_content earlier
const oldToolApp = `<span style="font-size: 0.7rem; font-weight: 800; color: #B45309; text-transform: uppercase;">Tool - App</span>
                                                        <h5 style="font-size: 1rem; font-weight: 800; color: var(--text-primary); margin: 0;">Công Cụ Số Hóa</h5>
                                                    </div>
                                                </div>
                                                <ul style="margin: 0; padding-left: 1.1rem; font-size: 0.825rem; color: var(--text-secondary); line-height: 1.55; list-style-type: disc;">
                                                    <li><strong>1 App tập trung duy nhất</strong> cho toàn công ty.</li>
                                                    <li>Đúng công cụ cho đúng việc theo phân hệ.</li>
                                                    <li>Số hóa đo lường 100% hoạt động.</li>
                                                </ul>`;

const newToolApp = `<span style="font-size: 0.7rem; font-weight: 800; color: #B45309; text-transform: uppercase;">Tool - App</span>
                                                        <h5 style="font-size: 1rem; font-weight: 800; color: var(--text-primary); margin: 0;">Công Cụ Hiện Đại</h5>
                                                    </div>
                                                </div>
                                                <ul style="margin: 0; padding-left: 1.1rem; font-size: 0.825rem; color: var(--text-secondary); line-height: 1.55; list-style-type: disc;">
                                                    <li>1 App tập trung duy nhất</li>
                                                    <li>Đúng công cụ cho đúng việc theo phân hệ.</li>
                                                </ul>`;
content = content.replace(oldToolApp, newToolApp);

fs.writeFileSync('index.html', content, 'utf8');
console.log('Update completed successfully via Node.js');
